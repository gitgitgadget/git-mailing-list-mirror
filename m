From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] cherry-pick: add --no-verify option
Date: Tue, 1 Mar 2016 19:33:12 -0500
Message-ID: <CAPig+cTT11J00aRO1gO06O6j5zdf4y6XRJhG5X7ZFeP6n7TOGQ@mail.gmail.com>
References: <56D576A1.3020202@greg0ire.fr>
	<1456864846-14185-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:33:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaujD-0004NJ-JO
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 01:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbcCBAdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 19:33:17 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34562 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbcCBAdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 19:33:13 -0500
Received: by mail-vk0-f43.google.com with SMTP id e185so185961759vkb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 16:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=gOwWtVEPR7K/Zr27AR3RnQ6MISGIR/THvjouTOcSUWI=;
        b=OkmulNP6rgdHFoatdAa+UKDePOnuIrve/C5rGxM1SpZfhX5e/RnYqOfYh+2gXUqqBc
         x+khN+TSYyxgKRicpuVmFOC69LZcH+RT67/l1QN3tt6j+4WiroGBfJU04eWaj0YnpVde
         okyJ53MEwZSw3EyWIsFVIiL2hc3qukGSEMOzn79SriH5tjIUJjTAz2BD8WWu6JrpzP/Y
         AAigVDcbM3q6VRAZjxh2z8Hs6BXlKcmoRNBr2CroklHOhBIr9fYgE88xy4ftR8xrlOEE
         xyQg1aK41Tn7XlHL/B6ZNabsBoxofQkCcO0MkvlZaMA2F8LB0UTLYtObywF04LTBbDpy
         evVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gOwWtVEPR7K/Zr27AR3RnQ6MISGIR/THvjouTOcSUWI=;
        b=B6aLC9dKkux+61aGyNLmImNRv1KocbQCGJQrpQfpQUkIoTrG/GHB2uSMmtoak86cUQ
         m5nfGcO+EKqBOJOMOPWgjinUpewulegeq16VQYAB+wqrQ+kUD8bu6aMwgmfF7/AS9C8b
         yfI+/2fvtSS7EzcB8sGGviwFSKUWWaVXtOPrCdlnmqbbqnURhftV2yEZs8x5glFRVjtg
         joM7a5Hs28bsJCmC8vr5rrojfcOSufhSLDLYK3nDlH+0NAWpe2u0QqjWpMS94wmoXaH+
         1azCqoPJlavm9q3UqOQZUFEP4P7Rh2l7QetvC50x6T0moTZKK8MOmWbNROwXNqqRbNH+
         kGyg==
X-Gm-Message-State: AD7BkJLV3v2nDFuFks/18/IokxF0JXnXxqIxh4a+6U+2kdeWPO7eR9uXay4oX4/FpnfGqj4ly54Wf+n1ZLJYdQ==
X-Received: by 10.31.8.142 with SMTP id 136mr18444547vki.14.1456878792078;
 Tue, 01 Mar 2016 16:33:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Mar 2016 16:33:12 -0800 (PST)
In-Reply-To: <1456864846-14185-1-git-send-email-me@ikke.info>
X-Google-Sender-Auth: 4uJEcGLk3VNWdbOctVSuJxjbS64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288085>

On Tue, Mar 1, 2016 at 3:40 PM, Kevin Daudt <me@ikke.info> wrote:
> git commit has a --no-verify option to prevent the pre-commit hook from
> running. When continuing a conflicted cherry-pick, git commit gets
> executed which also causes the pre-commit hook to be run.
>
> Add --no-verify and pass that through to the git commit command so that
> the can prevent that from happening
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> @@ -340,6 +340,18 @@ test_expect_success '--continue after resolving conflicts and committing' '
> +test_expect_success '--continue --no-verify does not run pre-commit hook ' '
> +       pristine_detach initial &&
> +       mkdir -p .git/hooks &&
> +       echo -e "#!/bin/sh\nexit 1" >.git/hooks/pre-commit &&

Non-portable 'echo'. You could use printf instead, however, even
better would be to use write_script() along with a here-doc (then you
could drop the 'chmod' also).

> +       chmod u+x .git/hooks/pre-commit &&
> +       test_when_finished "rm -r .git/hooks/" &&
> +
> +       test_must_fail git cherry-pick picked &&
> +       git add foo &&
> +       git cherry-pick --continue --no-verify
> +'
