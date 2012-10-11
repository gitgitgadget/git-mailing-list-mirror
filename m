From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Thu, 11 Oct 2012 08:44:38 +0700
Message-ID: <CACsJy8DMStBNjucU2eitNdkYgk-1K04dxhqV2gpKOZkpLzR_iA@mail.gmail.com>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 <5072973D.4080703@op5.se> <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
 <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de> <7vlifeawd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steffen Prohaska <prohaska@zib.de>, Andreas Ericsson <ae@op5.se>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 03:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM7py-0004JP-VG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 03:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab2JKBpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 21:45:12 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50424 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765Ab2JKBpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 21:45:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2144839iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 18:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h0G7buslgbdSZGF/kgT7zTcBi3gINKYJalrQIZBjbQ0=;
        b=cs5ozP43r4Ii3wd/9nWxSKmLc6zIjaVaOcOsLKGN8jDJfrQx13BTXptXANKXcX90B/
         MzqQc2D+yPqr/SDDGntwpQvyC3z3AnFfp/eKQtrc9ZatlywdAiN6HtQjG7HNDXCayJyc
         BXhD0UDsxoViRWVAxGq1TqTDVrw3WYjofufmi7ioHMKXlrYlaIpIQK35XZetdbap46vq
         QnI6JAd/JQCsH6+WsE0zNkxjIEFJI5KroA25YBbqp+YloX2x/5oLfToxx2VEarhalO10
         OqSRBzFIOBbbXl7QM3KKL6r5lsAOhkcQlC1Vn+UFrORbNnmAQ/74ACtXZKSmYbqKnGRd
         a8ug==
Received: by 10.50.236.39 with SMTP id ur7mr7120365igc.26.1349919909628; Wed,
 10 Oct 2012 18:45:09 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 18:44:38 -0700 (PDT)
In-Reply-To: <7vlifeawd5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207455>

On Thu, Oct 11, 2012 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Steffen Prohaska <prohaska@zib.de> writes:
>
>> I've recently discovered that the current protocol can be amazingly
>> inefficient when it comes to transferring binary objects.  Assuming two
>> repositories that are in sync.  After a 'git checkout --orphan && git
>> commit', a subsequent transfers sends all the blobs attached to the new
>> commit, although the other side already has all the blobs.
>
> I do not think it has anything to do with binary, but what you
> deserve from using orphan, where you declared that the history does
> not have anything to do with the original.
>
> If both of your repositories had the two paralle lines of these
> histories as branches, the transfer would have went well with or
> without binary objects.

On the same inefficient subject, git does not try to share common
objects for non-commit refs, for example tags pointing to trees. I
have such a peculiar repo and if a new tag shares 90% the tree with
existing tags, git-fetch to sends the whole tree of the new tag over
the wire. It does not seem easy to fix though and is probably rare
enough that does not justify proper support. As a work around, I
generate commits that link all these tags/trees together in a
predetermined order. Not nice but works ok.
-- 
Duy
