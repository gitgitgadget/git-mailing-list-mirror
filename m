From: Guilherme <guibufolo@gmail.com>
Subject: git config --get-urlmatch does not set exit code 1 when no match is found
Date: Sun, 28 Feb 2016 10:09:12 +0530
Message-ID: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 05:40:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZt9D-0006lP-Ll
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 05:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992793AbcB1Ejx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 23:39:53 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:32864 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992728AbcB1Ejw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 23:39:52 -0500
Received: by mail-vk0-f50.google.com with SMTP id k196so108956917vka.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 20:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=kDCUS00yenPeXM/mnOB0uIEW6Mw4Ubzrqna5REkU/Ms=;
        b=D4Mb1vY/161R3vStMkx3oKRIPRYAa3DcE2FxPz9LMDJHgFxfmPU9XzvnDFkZ4ftndQ
         wfetnMUUDhKPK9kubHI/9I+CKCraEDMRE65Ra842zwN2e/VDwbv3Z565Aa5e1V0D42hC
         H8uCrmxHp0RG28mQ1HQC57Dkm+lCkej48JmJHfTj8i7K4xufo5VOhRseQD5KpxtJRL6u
         VMIETfuWeYhirPMD0KM+6LUBXMpfcyzRHSHwvJnkwEuvF03p8Avo2jjJbrzyGraRi0JQ
         3NTXtxwHcWELStkP3d9fjwjGa4ota11McfyvNsJ1G+0lelMpmMLV5ySX6Q2DLZfzxewM
         dW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kDCUS00yenPeXM/mnOB0uIEW6Mw4Ubzrqna5REkU/Ms=;
        b=H2yv+/SCAcJDuoZfvz7HZ04jaLZ3wrS87uHDHeuD1K5Cg0WypkzZ8/y89l+3Z79Tvp
         X0RDVGMFrdr51TN8Mgq2l4pUZvGS9Q/68aXkTLADXvK3N2aMCVlGbhgL9KevJM74gkvT
         DLxiEslgujassgekBu9XgXm/odzasywl9uei8gaCT6LD1QPQpKKGHfsX+d+Gie7e5Pmo
         ClVX9lY1hEFo7L7a580lgv+rWVzSvWoc6feN8ANuASaK0LsIVJ3hKAzdU5n81htZhm+H
         B8NTiz57pYWaBZ1erUw6Df+y9hE3vReTZOASVySjl7IGhZU3WgEPc3rTkuYCfRp9bi2a
         xH1w==
X-Gm-Message-State: AD7BkJK2j/+VcwbeIg/atfoBARG1poDyxgv/8cWMZNUhhduEXtMztQksvDHCiREwQftKoqaMkhYHhdn9p4XtCA==
X-Received: by 10.31.138.73 with SMTP id m70mr6800639vkd.70.1456634391779;
 Sat, 27 Feb 2016 20:39:51 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Sat, 27 Feb 2016 20:39:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287740>

Hello,

My current woes are with multi-valued configuration values. More
specifically credential.helper

The documentation of git config says that when a value is not matched
it should return 1.

To reproduce make sure that credential.helper is not set.

git config --get-urlmatch credential.helper http://somedomain:1234/
echo %ERRORLEVEL%
0

git config --get credential.helper
echo %ERRORLEVEL%
1

git config --get credential.http://somedomain:1234/.helper
echo %ERRORLEVEL%
1

The documentation says that for credential.helper is not found for a
domain it should fall back to credential.helper if it is set. So I
think that all those tests above should have returned 0. Am i right?

Cheers.
