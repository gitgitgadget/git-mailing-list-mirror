From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Sun, 20 Sep 2015 18:29:41 -0400
Message-ID: <CAPig+cSFbYzLi8daS55B_sdvDPW4q6yOC5Hm75+Rmr-s1aFRHw@mail.gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
	<1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
	<CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>
	<4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 00:30:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdn7a-0000hG-8p
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbbITW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 18:29:42 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35481 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbITW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 18:29:42 -0400
Received: by vkao3 with SMTP id o3so55307290vka.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nSDOuVZjKCuki19Vxoxn3MPDdV1DHT2g+DnQvlTD46A=;
        b=Dlm2/tG2Mrf076CInbueCJ2uv1EYvhCPfEbB/cpiIO8beX9YVzUbuXF9ExfnQO5s9L
         UYLdNbpksjGZPSbb3pgJJmiBzD2lVTEipQWiPxj6cSiipm7J2oAee9y4A/WoyALqfx3k
         zzR6ao7aYZv/K4EilQh3MVgLAX/BRAoepAJr8buiiBjPJktxHH9V0yi1ofwvhcQTEMlU
         ATGMx2CCwUwwyEN3LjLuKoXkudXHXQisz8rR81cjFcNDo/coXCcK+bw4osmi6mnKpC9u
         1eHsC/4WbkjZkIXbCVhrzMYuUQgWypTIx8usX/rCG5ixJqJz31/f0tnZyZhsijaDv5zV
         h3nQ==
X-Received: by 10.31.6.20 with SMTP id 20mr11147186vkg.151.1442788181210; Sun,
 20 Sep 2015 15:29:41 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sun, 20 Sep 2015 15:29:41 -0700 (PDT)
In-Reply-To: <4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com>
X-Google-Sender-Auth: U3Us7E7ywZ8IpEsdldFNNny8cLo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278273>

On Sun, Sep 20, 2015 at 5:34 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 20 Sep 2015, at 23:16, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Sep 20, 2015 at 12:22 PM,  <larsxschneider@gmail.com> wrote:
>>> A P4 repository can get into a state where it contains a file with
>>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>>> attempts to retrieve the file then the process crashes with a
>>> "Translation of file content failed" error.
>>
>> Hmm, are these tests going to succeed only after patch 2/2 is applied?
>> If so, the order of these patches is backward since you want each
>> patch to be able to stand on its own and not introduce any sort of
>> breakage.
>
> Yes, these tests succeed only after 2/2. I think I saw this approach
> somewhere in the Git history. I thought it would ease the reviewing
> process: show the problem in the first commit, fix it in a
> subsequent commit.  However, I understand your point as 1/2 would
> break the build.

Yes, people sometimes do that, however, the patch which demonstrates
the problem uses test_expect_failure, and the follow-up patch which
fixes the problem flips it to test_expect_success.

> What is the preferred way by the Git community? Combine patch and
> test in one commit or a patch commit followed by a test commit? I
> would prefer to have everything in one commit.

If the tests are in a separate patch, Junio seems to prefer adding
them after the problem is fixes; the idea being that tests are added
to ensure that some future change doesn't break the feature, as
opposed to showing that your patch fixes a bug.

Whether or not to combine the fix with the new tests often depends
upon the length of the patches and how easy or hard it is to review
them. In this case, the fix itself is fairly short, but the tests are
slightly lengthy, so there may not be a clear cut answer. As a
reviewer, I tend to prefer smaller patches, however, this situation
doesn't demand it, so use your best judgment.
