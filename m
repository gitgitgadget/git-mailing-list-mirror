From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Fri, 7 Mar 2014 06:13:05 +0700
Message-ID: <CACsJy8B8=N6R6nVa12jjhxdqxMA2eGXOV6jR-XqRRbb-6Xppdg@mail.gmail.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
 <1394095783-24402-1-git-send-email-pclouds@gmail.com> <xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:13:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhTw-0006d7-E4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbaCFXNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:13:36 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:54605 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaCFXNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:13:35 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so3876457qcy.14
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r0m+4NRzIVikN8H1T6v0sOe7bCfwHtgZi8eVYSCm+iM=;
        b=X3mlu3F0tOpMJyobSr4Zr5Yz9n1CJs27Dmy2kKsBFttFfoweM9vNJAVwByPn/MBIdN
         5lZbPYHvp4dnXLYfZfD58fQxFLK0Fua0wTbb86KaKZAb4jzGhfYyi1VzV3rfGcIkvSzH
         EcGiw06UbpBZstemNhGENyvIl7bOx9z5o65X8ln1qweBEdJG6lKd6zimRsZurqdW+KHV
         DhCkbOpsPJONJMDW7NWfvulTDL4UmGi5yjeU3+nhhGmu7Lvd7cM33u3dp3fcgarqNMaH
         NkQaNLtSmqlnR3W2uzTRmDoa4IkjyVPUqA18YXdLdA7rLR6RJNROV2MHWmD2107j0bBE
         ymOw==
X-Received: by 10.224.112.6 with SMTP id u6mr17579892qap.78.1394147615223;
 Thu, 06 Mar 2014 15:13:35 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 15:13:05 -0800 (PST)
In-Reply-To: <xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243571>

On Fri, Mar 7, 2014 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I like what I see in this patch, but I wonder if we can essentially
> revert that "temporary shallow file" patch and replace it with the
> same (or a similar) mechanism uniformly?

Using --shallow-file is uniform.The only downside is temporary file.
Without it you'll need to think of a way (probably different way for
each command) to feed shallow info to.

> On the receive-pack side, the comment at the bottom of
> preprare_shallow_update() makes it clear that, if we wanted to use
> hooks, we cannot avoid having the proposed new shallow-file in a
> temporary file, which is unfortunate.  Do we have a similar issue on
> hooks on the upload-pack side?

No. I don't think we have hooks on upload-pack.

>>  builtin/pack-objects.c   |  7 +++++++
>>  shallow.c                |  2 ++
>>  t/t5537-fetch-shallow.sh | 13 +++++++++++++
>>  upload-pack.c            | 21 ++++++++++++---------
>>  4 files changed, 34 insertions(+), 9 deletions(-)
>
> Nothing for Documentation/ anywhere?

Heh git-pack-objects.txt never described stdin format. At least I
searched for --not in it and found none. So I gladly accepted the
situation and skipped doc update :D
-- 
Duy
