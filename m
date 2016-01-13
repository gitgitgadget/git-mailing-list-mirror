From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/3] Support `git pull --rebase=interactive`
Date: Wed, 13 Jan 2016 13:17:10 +0100 (CET)
Message-ID: <cover.1452687410.git.johannes.schindelin@gmx.de>
References: <cover.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKMe-0001oZ-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbcAMMRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:17:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:64865 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbcAMMRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:17:15 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M55BC-1ZxypN2Sxq-00zGfe; Wed, 13 Jan 2016 13:17:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452668201.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:d5Whg4rHK7qtF1bkVFVyP1/oJItHba/9dLAc3C/LzpKIOnS9J94
 jC4i53Lp3dbwtC0+LCfX0+trixSEW09/Clnim3r0OQ0wWxR0e7L7Ul4mTcjjsMIrJuvL4XA
 cAUGCEygyQhdLDOL5j5LWM9FzIqUGRkrLgLUCjQbKcs4PGbfS4zsHMCD0myBieYiOareABh
 eXzyHNtQEgZBKalzP30Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C3bF7AXbzm8=:5xeSxJTiBqjguRF+RjDIKI
 UH2dbeuiPvzUqYnwMKKhzwW8cvJAJo9TjX+mesArfLyazdwOQGCt23ljhR6ICHWVdu9BL+q8r
 urFr1YQ8/febeQ682G3X0+v8emK6GM7B4SdZJoSiU16uPbssAJQ3BZPPNfBvy/YDiBXYG3Kev
 W0tAEZF2kaqTKV0eRHy6qmJAY7h7TzulK4SGTljqWi4LR0KrF4Y3L2CWPo1punorlk8HVjscn
 LT6KuScgMuvCFURd77IMBmTFUNVleNmEXIuS5+x6kNkQKJra40smSWK5mJCocdCYxjrsGrUof
 bQPRI1h2I753aZ35zPg/XVptzrt/Tb12o93hnDpISfqdtAVskDBALcTIDfeiHow5Eo7ETXTJJ
 PLWcSAyl0ExA9ULlac7VZ0nNww/XYdqVQx88MBqiXZxUeQ2BJpgd/USuo5xEHcLc+2Av807Fo
 f8Y9IEnrXChBM7xCwE06TEyNo47CboBsTMpnv4tt5Dl7LihuZeFT949q/tWr5s6DiK0nBhEMW
 PegswODff6itOGR5octHFnOWs3Fc+fawm/B6mA2pbq4ZCFeasbEFWPASpe4VxMYbHAWiCW8Kp
 Th/NE14BKFYdRNm5ZK0TwUu+ieYTw9LToSyMFgCOYssD87oizb+UZjDBG0I9BDPaWeKLk0azK
 JSdLGK8qxv7jddOfCurLaqrKfaMqfkmjbtyG/vQGfG8CGHKOIZyfr/0cQe/DOa0/ZCC+e7amH
 IkFXMPcCbWSdmjqoLZ6qJLWDon/On4fHK/ir1noY0uIEaurcYiFotdYGhVwJUSd0QtnCH3wn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283904>

A couple of years ago, I found the need to collaborate on topic branches
that were rebased all the time, and I really needed to see what I was
rebasing when pulling, so I introduced an interactively-rebasing pull.

This patch series ports that work to the builtin pull.


Johannes Schindelin (3):
  pull: allow interactive rebase with --rebase=interactive
  remote: handle the config setting branch.*.rebase=interactive
  completion: add missing branch.*.rebase values

 Documentation/config.txt               |  4 ++++
 Documentation/git-pull.txt             |  4 +++-
 builtin/pull.c                         |  9 +++++++--
 builtin/remote.c                       | 10 +++++++---
 contrib/completion/git-completion.bash |  2 +-
 t/t5520-pull.sh                        | 10 ++++++++++
 6 files changed, 32 insertions(+), 7 deletions(-)

Interdiff vs v2:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index e5897e9..0f710ca 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -865,12 +865,13 @@ branch.<name>.rebase::
  	instead of merging the default branch from the default remote when
  	"git pull" is run. See "pull.rebase" for doing this in a non
  	branch-specific manner.
 -	When the value is `interactive`, the rebase is run in interactive mode.
  +
  When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
  +
 +When the value is `interactive`, the rebase is run in interactive mode.
 ++
  *NOTE*: this is a possibly dangerous operation; do *not* use
  it unless you understand the implications (see linkgit:git-rebase[1]
  for details).
 @@ -2158,6 +2159,8 @@ When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
  +
 +When the value is `interactive`, the rebase is run in interactive mode.
 ++
  *NOTE*: this is a possibly dangerous operation; do *not* use
  it unless you understand the implications (see linkgit:git-rebase[1]
  for details).
 diff --git a/builtin/pull.c b/builtin/pull.c
 index 832d0ad..c713fe0 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -116,7 +116,7 @@ static struct option pull_options[] = {
  	/* Options passed to git-merge or git-rebase */
  	OPT_GROUP(N_("Options related to merging")),
  	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
 -	  "false|true|preserve",
 +	  "false|true|preserve|interactive",
  	  N_("incorporate changes by rebasing rather than merging"),
  	  PARSE_OPT_OPTARG, parse_opt_rebase },
  	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,

-- 
2.6.3.windows.1.300.g1c25e49
