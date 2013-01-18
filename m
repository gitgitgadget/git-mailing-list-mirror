From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2] git-completion.bash: replace zsh notation that breaks bash 3.X
Date: Fri, 18 Jan 2013 11:24:01 -0800
Message-ID: <1358537041-29333-1-git-send-email-drafnel@gmail.com>
References: <CA+sFfMd7hurR=4n1r9RLtMYoxnM_LFH5j1McJc8+8_JumqviLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, schwab@linux-m68k.org,
	felipe.contreras@gmail.com, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 18 20:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHYb-0002uW-Up
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab3ARTYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:24:33 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:17043 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3ARTYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:24:32 -0500
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B50f9a1500001>; Fri, 18 Jan 2013 11:24:00 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Fri, 18 Jan 2013 11:23:16 -0800
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Fri, 18 Jan 2013 11:23:16 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 18 Jan 2013
 11:24:15 -0800
X-Mailer: git-send-email 1.8.1.1.251.g53179c5
In-Reply-To: <CA+sFfMd7hurR=4n1r9RLtMYoxnM_LFH5j1McJc8+8_JumqviLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213930>

When commit d8b45314 began separating the zsh completion from the bash
completion, it introduced a zsh completion "bridge" section into the bash
completion script for zsh users to use until they migrated to the zsh
script.  The zsh '+=()' append-to-array notation prevents bash 3.00.15 on
CentOS 4.x from loading the completion script and breaks test 9902.  We can
easily work around this by using standard Bash array notation.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


On Fri, Jan 18, 2013 at 7:02 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> +                             array[$(($#array+1))]="$c"
>
> You don't need $(( )) since the array index is already evaluated as an
> arithmethic expression.

Fixed.

-Brandon


 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..2f99420 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2431,7 +2431,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 				--*=*|*.) ;;
 				*) c="$c " ;;
 				esac
-				array+=("$c")
+				array[$#array+1]="$c"
 			done
 			compset -P '*[=:]'
 			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-- 
1.7.8.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
