From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Wed, 22 Apr 2015 21:30:20 +0200
Message-ID: <CAMpP7NbruKC97L1ROXV0Up9Fks8FJmgB_nxTTWpSHp-8VVE+Xw@mail.gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	<20150420221414.GA13813@hank>
	<CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
	<20150421212427.GB13230@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0Lr-0003uu-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbbDVTaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:30:22 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36862 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbbDVTaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:30:21 -0400
Received: by obbeb7 with SMTP id eb7so178301748obb.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jpD5qqy0T9EfX1cIPjWeeYtFA2KAGum5Ggc+NiJKmME=;
        b=ng+cXwqhPFUKF7NmyCex9lHNI3DQj9tRAba9/ySOORZ6p2Y4Xl8/qFmyY+d6YcUUpf
         ZVlFQgfhM2U3fa7HnWlASy6yr/PdoYI9ZtkGGR65x0VXqElrW4kjxBUZpUpOg44Xcpx5
         C5/k5WaSriVgYIPIGdRY/4mQDwgs89MgPCJ5tuI43xvSIInKzs/H0KNYBb16PvAiTxEJ
         ehvtfpgVQV7EuYXTijjsp4goGCfsn+NH7QH4GVEbP2mbBGE5wslD0grCkI2xZstVjP/v
         dhG658zgu6VxJBVu3lzaaGrESx2StVbH2fFtOHxZNr6iyCYvMuoNy2o2gBnHnKD8f4jy
         FA3g==
X-Received: by 10.202.198.149 with SMTP id w143mr1401499oif.72.1429731021046;
 Wed, 22 Apr 2015 12:30:21 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Wed, 22 Apr 2015 12:30:20 -0700 (PDT)
In-Reply-To: <20150421212427.GB13230@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267618>

On Tue, Apr 21, 2015 at 11:24 PM, Jeff King <peff@peff.net> wrote:
>
> If I understand correctly, the reason that you need per-run setup is
> that your "git clean" command actually cleans things, and you need to
> restore the original state for each time-trial. Can you instead use "git
> clean -n" to do a dry-run? I think what you are timing is really the
> "figure out what to clean" step, and not the cleaning itself.
>
> -Peff


Yes, that is the problem. A dry run will spot this particular performance
issue but maybe we lose some value as a general performance test if
we only do "half" the clean? Admittedly we clearly lose some value in
the current state as well due to the copying taking more time than the
cleaning. I could go either way here.

/Erik
