From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a
 commit
Date: Wed, 27 May 2015 08:28:42 +0200
Organization: gmx
Message-ID: <c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 08:28:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUpf-0000d2-0s
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbbE0G2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 02:28:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:50789 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbbE0G2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:28:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lw2Sj-1ZBZuI1nPp-017jJn; Wed, 27 May 2015 08:28:43
 +0200
In-Reply-To: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:3UTX5L8s8AYbjfUeGsmny1nctsLBUuD+JeeyB+EeTa06V66lrsC
 UAPHb0bNXXiI/ljUFJHKb4UVZPIrdBLC3gTB/QjAnnb+ard54N+1CHXBPX1bMBcmXb7dHfR
 kBjOxavrJ4w1AKgEzeihj3fDMHvToA/yWpHzFhzOnQC0Yt7Fs4mGxC09QLBjfRHRfGZvOoh
 AJoBVdlJAG1SdMaKoOPNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270017>

Hi R=C3=A9mi,

On 2015-05-26 23:38, Galan R=C3=A9mi wrote:
> Instead of removing a line to remove the commit, you can use the key
> word "drop" (just like "pick" or "edit"). It has the same effect as
> deleting the line (removing the commit) except that you keep a visual
> trace of your actions, allowing a better control and reducing the
> possibility of removing a commit by mistake.

Please note that you can already just comment-out the line if you need =
to keep a visual trace.

Alternatively, you can replace the `pick` command by `noop`.

If you really need the `drop` command (with which I am not 100% happy b=
ecause I already envisage users appending a `drop A` to an edit script =
"pick A; pick B; pick C" and expecting A *not to be picked*), then it i=
s better to just add the `drop` part to the already existing `noop` cla=
use:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f7deeb0..8355be8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -489,7 +489,7 @@ do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
 	read -r command sha1 rest < "$todo"
 	case "$command" in
-	"$comment_char"*|''|noop)
+	"$comment_char"*|''|noop|drop)
 		mark_action_done
 		;;
 	pick|p)

Ciao,
Johannes
