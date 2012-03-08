From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 8 Mar 2012 12:36:43 +0100
Message-ID: <CAJh6GrGch9JHYnGW+K-wxdX9wPRry4Lxi2ysTtt0g9FTF4ThTQ@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com> <4F589611.6060106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:37:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5beg-0007LD-IL
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab2CHLhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:37:06 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:32853 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2CHLhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:37:05 -0500
Received: by wejx9 with SMTP id x9so243328wej.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=rboDU5hMwOE/8gKxJgGuR/3JJZQZuSGaw9m+DViFTko=;
        b=cn6LqawdIeVh5NQtXut90XgP7WSEDIgJbCzB/zlfIn4C8lGNOYXmytZ/efpVrcUVQA
         jnFBB/Fy7w1IebnmDkTXxF3d3ZeDQqawVVMEx7KbFn459XnNBYoIkuhygLrSuTGhbDFf
         a2sGqFLJ1mx+4sLE9PaMWekXoZpatoSNU+F8LjJ+K47UpCzn8uV5FBMvJRSQrurQa44X
         5owYwiuw/OIiYuYsyILbMHgXPjLMWIOmsytZobuKwgPmtnMms6sc2LitbodI3WjqHD0k
         YoR0eXGeZXYemZxlf8UJ1Bf5TwDsa7xaClSv6/WUC4edkv5tO9Qp0qESXkXH3mclQm97
         /5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=rboDU5hMwOE/8gKxJgGuR/3JJZQZuSGaw9m+DViFTko=;
        b=g5qdm1q52gZya+xZdECj3XfODtl9GpsgPu+x0+NiiAuTgg39pnwX/Zvuqos3nDfFKC
         hdFm2dnhfT1oQHQiLnRSGIvRy1GS8Iy8TE5b02CtmTaxWRclVcHheJ8Phnc1FtFTtayM
         zw61lQAUwodlwmw+YdlgNHA4BE/OJzh/i0LenUNSOAoHFaO+27KZU0pybCulAKxrsSTb
         g67bae2mwQ8Pi7hf97/c/xZJrB85j80P7Eh7yG7223W5ScHzINc6W8kBXIBR1NUrrzGX
         xwi/12iP52P/wByGiK3aWAtoB3Kmxg9ue2MfisUNPpiiWYLNxV0zDNuJeIjzV2O/taAa
         1mHA==
Received: by 10.216.138.17 with SMTP id z17mr3109670wei.18.1331206623421;
        Thu, 08 Mar 2012 03:37:03 -0800 (PST)
Received: by 10.216.138.17 with SMTP id z17mr3109657wei.18.1331206623298; Thu,
 08 Mar 2012 03:37:03 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Thu, 8 Mar 2012 03:36:43 -0800 (PST)
In-Reply-To: <4F589611.6060106@viscovery.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQms+kugNBKllsKNGywRxrlxudZgium1G1umnBXO1L1TqOtfpL37sJUqD0ATUg0bCLzbGRVmkrHAZm8GUUiQm8wGxI8s5TY4xdY+/sYkomFZwzKZCEirWnXpesGTubsvCU15wTcKtnfdooqlWYIMSVNX2ds7JQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192566>

On Thu, Mar 8, 2012 at 12:20 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 3/8/2012 11:42, schrieb Dominique Quatravaux:
>> + =A0 =A0 shortsha1=3D$(echo $sha1 | cut -c1-7)
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 sha1=3D$(git rev-parse $shortsha1)
>
> Why do you call it "optimization" when you spend two or three subproc=
esses
> instead of one?

echo is a shell internal. "git rev-parse" is two processes just as
"cut" and a pipe. The difference is that cut doesn't hit the git
repository.

But the real purpose of this first change is to lay the ground for the
next one, so I'd be happy to change the patch description...


--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
