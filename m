From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Thu, 14 May 2015 13:06:39 -0700
Message-ID: <xmqqiobukjow.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:06:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YszP6-0002cq-9w
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbbENUGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:06:43 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36017 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965023AbbENUGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:06:42 -0400
Received: by igbpi8 with SMTP id pi8so176967794igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w14jFkF0ed+e6tMOmaxq4cEjum02GMf3FvlgZhpg5aM=;
        b=EHEgcWiK0l2pSwTB+GnfkCCD9/qcUs6y9p9jxpKmDgy1i5kyEfOL4pt6gKKI936kqo
         ysJtrpotc7cY46Z+oj6wjCL45YuM+3dZVZvoVjYvIRk8+Y0Itm0BuDeRDHiGysLrh61s
         wfc7pKA5Pc2DygPyDepFWl8+9XbseqE2NpvU4gJ8Nn2/IqGhHkgn1e8cZgWdo1Uy/sll
         Pn/WYUevSh2PKQEhXNi3G2jqsQx48bCfsA3t2V2ywTTXmRh2KZEvTjWFXplBUmIEvbba
         AHZA13xuxcQlzXEh/aLM0ChU5wCchanqmQXqoxijWCHlaEY36NyTviFTs2RFNGnCGgQk
         +uOw==
X-Received: by 10.50.79.228 with SMTP id m4mr16435412igx.42.1431634001854;
        Thu, 14 May 2015 13:06:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id 71sm46720ioe.16.2015.05.14.13.06.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 13:06:40 -0700 (PDT)
In-Reply-To: <1431455779.16652.20.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 14:36:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269078>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-05-12 at 11:07 -0700, Junio C Hamano wrote:
>
>>  * Is it fundamental that this is only for --batch family, or is it
>>    just lack of need by the current implementor and implementation?
>>    "git cat-file --follow-symlinks blob :RelNotes" does not sound
>>    a nonsense request to me.
>
> The reason that --follow-symlinks doesn't work for non-batch requests is
> that it is impossible to distinguish out-of-tree symlinks from valid
> output in non-batch output. I will add text explaining this. 

Actually, I do not think that is a valid reason not to consider
supporting "git cat-file --follow-symlinks blob :RelNotes" in future
versions of Git.  "--batch" and "--batch-check" needs to continue,
so it needs to give diagnosis in-line in its output and let the
driving script continue talking with it, but a single-shot request
"git cat-file --follow-symlinks blob :RelNotes" can signal that
the link does not resolve in-tree (or in-index) by erroring out.

So I still view it as "we currently do not need it outside --batch;
if somebody wants to, feel free to add it to non-batch mode".  It
does not have to be called a bug but I would say it is a missing
feature.  And not handling an in-index path e.g. :RelNotes falls
into the same category, I would say.

Just to avoid misunderstanding, I still think this series (at its
9th iteration) is good from the point of new feature without filling
these two missing features.
