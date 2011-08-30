From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Tue, 30 Aug 2011 10:28:33 +0200
Message-ID: <CAOxFTczyNtyLWyXppj=0UW_zeD3t+rDtzt-vwqXkwvWOTdxi2g@mail.gmail.com>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7v62lg6tr3.fsf@alter.siamese.dyndns.org> <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
 <7vd3fo53oe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 10:29:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyJgs-0002sm-2Q
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 10:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab1H3I25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 04:28:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63855 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1H3I2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 04:28:54 -0400
Received: by gya6 with SMTP id 6so5433626gya.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Itx7wdlzLMcjsJ7SyL6IUd6JwScVyIigCMx/BaabEqo=;
        b=NRmkhRzpn+uERx6+BC+6xrPQy0m+e2tZQPJlyMI7AzCTkW3vODQFkUYAQrWMFqrKT0
         48bqama5u9Jq3xShC9iHTYv+O1yb2iaESnGhORMP5khXtOUoS1BTt9RFCSla82i6vcmz
         6iCxt/D3k2Q7tDmTfg7Bl4MfrgfiLhjWnNVkk=
Received: by 10.42.37.212 with SMTP id z20mr6497838icd.209.1314692933245; Tue,
 30 Aug 2011 01:28:53 -0700 (PDT)
Received: by 10.231.14.131 with HTTP; Tue, 30 Aug 2011 01:28:33 -0700 (PDT)
In-Reply-To: <7vd3fo53oe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180394>

On Mon, Aug 29, 2011 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Nope, it doesn't have index .... lines. Still, the patches seems to
>> apply correctly. Well, the couple of patches I tested did, at least,
>> even though they were marked as diff --git and they were lacking the
>> index ... lines.
>
> Does "am -3" do the right thing when the patch does not apply cleanly, for
> example?

three-way merges are impossible because all hash information is being
stripped (hg stores them in the Node ID and Parent metadata, which we
strip, and has no index metadata for the actual diff blocks). This is
correctly detected by -3, with

Applying: Threeway test
fatal: sha1 information is lacking or useless (dir.h).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 Threeway test

The message is a bit misleading (it's not the repo lacking the blobs,
it's the patch missing the information), but the process fails as
expected.

> What about renaming patches?

They lack similarity indices, but they seem to be properly formated
(and the simple cases I tested apply correctly).

In fact, stripping the --git from an hg patch containing a rename
makes the patch unusable:

error: datetime.move: does not exist in index
Patch failed at 0001 Move

So I think that keeping the --git is the right choice.

-- 
Giuseppe "Oblomov" Bilotta
