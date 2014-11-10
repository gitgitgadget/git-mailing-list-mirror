From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Mon, 10 Nov 2014 15:41:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <cover.1415630072.git.johannes.schindelin@gmx.de> <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 10 15:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnq9p-0002eM-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 15:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbaKJOl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 09:41:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:52710 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbaKJOlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 09:41:25 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LfSyv-1YL1G31Au9-00p1LE;
 Mon, 10 Nov 2014 15:41:10 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:dPq4lcjZkn4R2jU65aIhDNKDg6mD/tVLvW93kLkRa09a04E2usL
 kCFDcDaQrGLJs1cQCwPcLwEarKFUlym5yzbSvT9uzyB3JvZ+aZiCMnDtiZLAVa7f8jczyE7
 QvLjcYoQAVeYZ5gQFE+0vP6oYXOA79jw56Ijcp1fyiVhrgqRz+xxiIIqrZh4fYZtfe+pOoF
 FMm2IlNSQYu2fOm0ZNbuQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 10 Nov 2014, Johannes Schindelin wrote:

> In start_command(), unset "env" fields are initialized via "env_array". In
> finish_command(), the "env_array" is cleared, therefore the "env" field
> will point to free()d data.
> 
> However, start_command() will set "env" to env_array.argv only if "env"
> was unset to begin with, and if it was already set, the caller will need
> the original value. Therefore, we need to be very careful only to reset
> "env" in finish_command() when it has been initialized in start_command().

In case it was unclear: this is needed for the the suggested switch from the
previous method to construct the environment to the new env_array method
to work.

(The env_array method unfortunately requires the code to initialize the
environment twice because finish_command() insists on always releasing the
env_array, even if the caller may want to reuse the generated array).

Ciao,
Johannes
