From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 09/13] refactor duplicated ref_newer() to remote.c
Date: Mon, 23 Feb 2009 08:41:22 -0500
Message-ID: <76718490902230541k584e469bp5530b605bb700ef9@mail.gmail.com>
References: <20090223064510.GA24517@coredump.intra.peff.net>
	 <1235374171-92523-1-git-send-email-jaysoffian@gmail.com>
	 <49A263FB.7030308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 14:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbb5B-00006P-Nb
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 14:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbZBWNlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbZBWNlX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 08:41:23 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:1796 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZBWNlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 08:41:22 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1939135rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 05:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xt7vzQbeXERHop+lFgXSQsLEf1ino2jWOHK1rlXrMbs=;
        b=w9mG6O8gnJ8dU1t4P4lQu/dEW0C0uQfW22On+ftlilR2BKAogosNbMvTceFjqwgte6
         zcICfFbhnncn/qZ9Qk7vx3/4Wf79Sa3SUOgSXB6IU4E/sCpMFq4rjQh2vmiPzDPU/YiG
         kqoJ+7KpzcRHTfbHCl8Wzh5600kcV4TaqfozU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v1e5OzkTcFQqV5ul05TdFYaZqzyp36d4O19ORnLERLOyJ1R6eeNeLchE50U2xMD/t1
         HutoVEo0buvi6y9iYFFByOimo9J2ushhegPmcpLVnMJpjEeQGy+PmPGeSBe33bt8v9pI
         YH3OZSpvYAbi7IgC3H9muxFRMI28K8qcQgxFM=
Received: by 10.141.96.19 with SMTP id y19mr2040544rvl.201.1235396482139; Mon, 
	23 Feb 2009 05:41:22 -0800 (PST)
In-Reply-To: <49A263FB.7030308@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111135>

On Mon, Feb 23, 2009 at 3:53 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Jay Soffian schrieb:
>> diff --git a/remote.c b/remote.c
>> index 2c010a1..d0053d5 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -5,6 +5,7 @@
>>  #include "diff.h"
>>  #include "revision.h"
>>  #include "dir.h"
>> +#include "tag.h"
>
> You are only moving code from http-push.c and builtin-send-pack.c to
> remote.c, but you have to add this '#include "tag.h"' here. How high are
> the chances that you can remove the #include lines from http-push.c and
> builtin-send-pack.c?

50/50 as it turns out. Junio, please squash this in if you don't mind:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 186cecb..9072905 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "tag.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"


j.
