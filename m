From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 16:48:16 -0600
Message-ID: <3222724986386016520@unknownmsgid>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan> <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan> <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan> <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 23:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFY0F-0004TN-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 23:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894Ab3CLWsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 18:48:21 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:59263 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933759Ab3CLWsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 18:48:18 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so132603dad.18
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:from:in-reply-to:mime-version:date:message-id
         :subject:to:cc:content-type;
        bh=CIcyWK5QulAGVaderzVi7aQE+HZHn1qew2px3V0jyoA=;
        b=tkbkohWVTFio/yyA8Bxuq9UJBC/m9Qqvgfq6lW0kTPOstcUkXS1bsbS90oANQzb15b
         4pTPQDuE6rfljC8xi52iJ4xUZgILA3sl+fn4HpcXxNotQNdZVJsIHVXzAFukmE83mPyN
         w1ZXA2qw+PTgTfFljAGh+1AWyQaGBs5B7w2kEdu2pi+/VeSfjFfLIxo1endBnRtX+s5A
         u3nlparM439IOCabwQU7MXs1krgehQ/YKlq7AOuYbDi7TCro+NWFrFpIfzIgFBfmudJL
         GUFqDTdXS0CdED6GFek+Bp8w3pquRmQ2+qIJ9Uc7zt8PeQGCaJdv70LPA65IXK8Wo6N2
         3FTQ==
X-Received: by 10.68.194.8 with SMTP id hs8mr18340175pbc.44.1363128497916;
 Tue, 12 Mar 2013 15:48:17 -0700 (PDT)
In-Reply-To: <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218006>

On Mar 12, 2013, at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Matt McClure <matthewlmcclure@gmail.com> writes:
>
>> An alternative approach would be to reuse git-diff's option parsing
>
> I do not think you want to go there.  That wouldn't solve the third
> case in my previous message, no?

I think I don't fully understand your third bullet.

> * If you are comparing two trees, and especially if your RHS is not
>   HEAD, you will send everything to a temporary without
>   symlinks. Any edit made by the user will be lost.

I think you're suggesting to use a symlink any time the content of any
given RHS revision is the same as the working tree.

I imagine that might confuse me as a user. It would create
circumstances where some files are symlinked and others aren't for
reasons that won't be straightforward.

I imagine solving that case, I might instead implement a copy back to
the working tree with conflict detection/resolution. Some earlier
iterations of the directory diff feature used copy back without
conflict detection and created situations where I clobbered my own
changes by finishing a directory diff after making edits concurrently.
