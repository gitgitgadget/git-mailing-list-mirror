From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 19:14:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231911470.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info> <xmqqmw6e499u.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
 <xmqqa92e47ap.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info> <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com> <xmqqsig62q78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TzJ-0004ay-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaLWSPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:15:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:57860 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaLWSPC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:15:02 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MD9q8-1Y6kAe3oAW-00Galt;
 Tue, 23 Dec 2014 19:14:56 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqsig62q78.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:D5wFkdOdRvgDupN8IDv8lDjrjIQyFUmoTJGgbs3JNnedSvegxX5
 c/jul5odf9kTeReT8JwkObeerpgstmB+dxNtOmShS+IvyeR7QSw+2tFDL8dQzRid5e+xWSw
 pAgNda3KMwOFHsjBr3MQjIIJEXBIDhjiLeslP4lu+li83UZINV9ZDBE2FOAGHkbS/k7NyZI
 90BgsCsNgYWnzrWbBGAgg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261755>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Having said that, I think "missingTags" etc. should not be configuration
> variable names (instead, they should be values).
> 
> Because of that, I do not think we need consistency between the way
> these "tokens that denote kinds of errors fsck denotes" are spelled and
> the way "configuration variable names" are spelled.

Okay. That makes more sense.

Now I can remove the complexity introduced by teaching the parser to
accept camelCased values, and we're golden.

> In either case, I'd recommend that we take [ ,]+ as inter-token
> separator to ease the use on the command line and config file

And this is indeed the case:

+void fsck_strict_mode(struct fsck_options *options, const char *mode)
+...
+       while (*mode) {
+               int len = strcspn(mode, " ,|"), equal, msg_id;
+...

In other words, I even allowed the pipe symbol as separator.

Ciao,
Dscho
