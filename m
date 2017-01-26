Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135BB1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 16:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbdAZQQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 11:16:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:51030 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753324AbdAZQQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 11:16:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lymoh-1cTQPw43Gh-01680n; Thu, 26
 Jan 2017 17:08:32 +0100
Date:   Thu, 26 Jan 2017 17:08:29 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 0/1] Let `git status` handle a not-yet-started `rebase
 -i` gracefully
In-Reply-To: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1485446899.git.johannes.schindelin@gmx.de>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:voXo8Zpb+H6tAcy4uicBstKEc1fg1vhhCZOXz7YNZkTcotftu/t
 t3EPGWP0hie18VeY3pHx+IwR0L+cFPkODkEWgzjlHT7FCeT6s3qoiJ/F9SFYR5rxA8FiLH2
 nICQ833XhKZ7GnvRIvlTYvp2+Ur1+CWN+2qhJsSmbfYpmkcYx3gtnYmpc/I7BJ3SnC6xv2b
 uEbdSzrEdpdA9XP5eZqew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Obi9t36Pac0=:tqad6/qvVTsKf8xvgktoGV
 yxqBpNjbI7YjFzHajC97WZGFPIBH2WCgZFLQAM9j9ECy32FlRQFOd/3qVTStllw6MJTwQ3RH8
 7ohGqa7cHZd49QRJmsnCpNpYDeGAZ4PJySgRH+PhlML4a//ywK2QJZV2QAN0hUceqMo5qojtX
 kMmm973PV1EfwbzA429Id1TNrxk37a6MgeT8ox3JHY7w+yZrjj2DHbpjqEMjFo5LCR7ANfRMv
 D2FAkvmNDyvNMzq5KEelBrcOaQ9JMKo95hPRni4MEpjtQzRaAnvnjRO/NsHqunlJYyMvWEqJ5
 /UzedUNRiJbPzOPu8JG7Ib/szCoCuzYH8SrhZq0NIzj0DTOnsnNZKv2vrYKWoLfJeHk0sHVeO
 UB0aY1G3S7fB8Vc2fbKCiwcYRZrM8JWmvqhWVIEaIw8SmnggrRmzzpJQaeJkgwFhmc2Ch5hDD
 /OvrSyK5k4815mfvpf2NF/RDcKwqLi1DtdF4uQDMVE0YIDrw85dxdF4XRSg7FQ8yG5Hahrik9
 BCmHQ5T29dIc3tSKHJ7gghhGVc7Y6bA3moc14h8rVyncAVkFdpQtc2Q9eYiuHXLQmwZxx5Xi5
 /gaCiOp6Yf/MPPle7PVJrhMsIaMezSF8saZtd+Oq/poYPnG2OBfgpe6c99oA0dq5oGv6vSXhZ
 l/oqQtgRWqZWvHwcEKV0SaHrq143Hh9CDaLYG5nsXwuvP5DKmGKGmwg8HGdcKYDLy5wLgdsYQ
 MmoKvBeRMUiwOlRiPtnJmHJfdusKw+eLFabq6FxhPAGGVzbfdNY+U1gSH+oYHihYKwqtog2n8
 2iDqApF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the `done` file is missing, we die()d. This is not necessary, we
can do much better than that.

Changes since v1:

- When `done` is missing, we still read `git-rebase-todo` and report the
  next steps.

- We now report a missing git-rebase-todo.

- Added a test (thanks, Matthieu, for prodding me into working harder
  ;-)).

- As I changed so much, I took authorship of the patch.


Johannes Schindelin (1):
  status: be prepared for not-yet-started interactive rebase

 t/t7512-status-help.sh | 19 +++++++++++++++++++
 wt-status.c            | 14 ++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)


base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
Published-As: https://github.com/dscho/git/releases/tag/wt-status-v2
Fetch-It-Via: git fetch https://github.com/dscho/git wt-status-v2

Interdiff vs v1:

 diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
 index 5c3db656df..458608cc1e 100755
 --- a/t/t7512-status-help.sh
 +++ b/t/t7512-status-help.sh
 @@ -944,4 +944,23 @@ EOF
  	test_i18ncmp expected actual
  '
  
 +test_expect_success 'status: handle not-yet-started rebase -i gracefully' '
 +	ONTO=$(git rev-parse --short HEAD^) &&
 +	COMMIT=$(git rev-parse --short HEAD) &&
 +	EDITOR="git status --untracked-files=no >actual" git rebase -i HEAD^ &&
 +	cat >expected <<EOF &&
 +On branch several_commits
 +No commands done.
 +Next command to do (1 remaining command):
 +   pick $COMMIT four_commit
 +  (use "git rebase --edit-todo" to view and edit)
 +You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
 +  (use "git commit --amend" to amend the current commit)
 +  (use "git rebase --continue" once you are satisfied with your changes)
 +
 +nothing to commit (use -u to show untracked files)
 +EOF
 +	test_i18ncmp expected actual
 +'
 +
  test_done
 diff --git a/wt-status.c b/wt-status.c
 index 13afe66649..4dff0b3e21 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -1169,12 +1169,12 @@ static void show_rebase_information(struct wt_status *s,
  		struct string_list have_done = STRING_LIST_INIT_DUP;
  		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
  
 -		if ((read_rebase_todolist("rebase-merge/done", &have_done)) ||
 -		    (read_rebase_todolist("rebase-merge/git-rebase-todo",
 -				  &yet_to_do)))
 +		read_rebase_todolist("rebase-merge/done", &have_done);
 +		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
 +					 &yet_to_do))
  			status_printf_ln(s, color,
 -				_("rebase-i not started yet."));
 -		else if (have_done.nr == 0)
 +				_("git-rebase-todo is missing."));
 +		if (have_done.nr == 0)
  			status_printf_ln(s, color, _("No commands done."));
  		else {
  			status_printf_ln(s, color,
 @@ -1192,9 +1192,7 @@ static void show_rebase_information(struct wt_status *s,
  					_("  (see more in file %s)"), git_path("rebase-merge/done"));
  		}
  
 -		if (have_done.nr == 0)
 -			; /* do nothing */
 -		else if (yet_to_do.nr == 0)
 +		if (yet_to_do.nr == 0)
  			status_printf_ln(s, color,
  					 _("No commands remaining."));
  		else {

-- 
2.11.1.windows.prerelease.2.9.g3014b57

