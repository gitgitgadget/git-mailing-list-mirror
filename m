From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 10:59:10 -0700
Message-ID: <CAGZ79kZvi+qJKPkgzHP5LgoyTJd2btJZ6zCc4hkSKAhjoOiYFg@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
	<xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOMdozVafJzRYJmhhAAAAVfLJ74dSGVbsHreFFKD1Vobg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:59:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQaU-000765-B7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759660AbcCVR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:59:13 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33557 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759657AbcCVR7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:59:11 -0400
Received: by mail-yw0-f177.google.com with SMTP id h65so121620484ywe.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BBjPAUzoc1NhCTQ9xumJDQ7j0FQ8X35wcP4gfgcGMi8=;
        b=Db6JvHCCha2bVKfanNQ68PCqm0u5Zu53P2YsGfBpso2MlcZa7fbwasq9+XVkCu7TEm
         GVzhJxwbp/0Mhv7JbcUmgd85E+Gr7eFd95Rt1fQ70pDo60jceNwMEClC9BedygZEQUZ4
         RjK0o+fE+nYryrMbcSnxoBtb1/dorQjMExIfSbBQ8FQ40T2VUGS5xdKaamYVsVvd6iDU
         NzBV1NCrLO7BtzFVg4VU+xJ1uUURX0WFQiyyrZ2oPVe8THTTZ3749/DjJO5HFrfGnYSs
         aSrFfQhcunMgsFPdT4v31/ONCLm7QaaupnX2nu5zRmav9DzlCp4AiCVfym4gOkWuYUXm
         Ue1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BBjPAUzoc1NhCTQ9xumJDQ7j0FQ8X35wcP4gfgcGMi8=;
        b=RhVSskvGURZVZr39z2Vr86glkYxlRJl/45yx8dlVW6Ajt7zjte6inTUyNTmxSibVHH
         YAZJmN9iquvmk4a2NdsEPxIbD6ICUw60MCfFNSyAEGx1wB5SL87pJeZAlaxXAUwcmk8I
         Cre5ywzhpE+7D2/lNvG5Se37clMAhXwj1ulmL89l2k8zOH8g0qktboSPAAyB7T6iSXl/
         EubaSSGpDPfZUOiODyQYA0uaV8xfHtRXmATyerX37Z0KWL4T4TS2pn4IQ1Vsu+YbgFRX
         cgUKSERkw7zyIByHg0zW1FppOkHmVMsTPVdQVbHTftSs1dRS7TCE8U4ZljVwBLYjCidK
         iMpw==
X-Gm-Message-State: AD7BkJJm2LODltiEF35RggobQqTpseCeEa1ARCOa6yomQQj/1jAzjTz0Y19DQk9hBkXTXdLxn9K4lKo+sJm7eh74
X-Received: by 10.37.38.8 with SMTP id m8mr18390763ybm.92.1458669550588; Tue,
 22 Mar 2016 10:59:10 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 10:59:10 -0700 (PDT)
In-Reply-To: <CAFZEwPOMdozVafJzRYJmhhAAAAVfLJ74dSGVbsHreFFKD1Vobg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289534>

On Tue, Mar 22, 2016 at 10:52 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> OPT_CMDMODE() is actually a better option. I also noticed that it
> isn't mentioned in Documentation/technical/api-parse-options.txt .
> Should I send a patch to include it there just to make it easier for
> someone who is new and isn't aware of the changes ?

Patches to outdated documentation are most awesome. ;)
