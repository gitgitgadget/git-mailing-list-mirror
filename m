From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 7/7] rebase (without -p): correctly calculate patches
 to rebase
Date: Fri, 20 Jul 2012 10:18:49 +0200
Message-ID: <50091469.5030307@viscovery.net>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-7-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-8-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Knut Franke <Knut.Franke@gmx.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 10:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ss8QO-000215-0P
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 10:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab2GTISy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 04:18:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33784 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab2GTISx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 04:18:53 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ss8Ru-0005i1-OO; Fri, 20 Jul 2012 10:20:37 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6E0551660F;
	Fri, 20 Jul 2012 10:18:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1342596455-17046-8-git-send-email-martin.von.zweigbergk@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201763>

Am 7/18/2012 9:27, schrieb Martin von Zweigbergk:
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 37c1b23..fe3fdd1 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -16,11 +16,9 @@ skip)
>  	;;
>  esac
>  
> -test -n "$rebase_root" && root_flag=--root
>  test -n "$keep_empty" && git_am_opt="$git_am_opt --keep-empty"
> -git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> -	--src-prefix=a/ --dst-prefix=b/ \
> -	--no-renames $root_flag "$revisions" |
> +generate_revisions |
> +sed -e 's/\([0-9a-f]\{40\}\)/From \1 Mon Sep 17 00:00:00 2001/' |
>  git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
>  move_to_original_branch

Just curious (as all tests pass): What does this do? It looks like
format-patch is not called anymore and git-am sees only SHA1s. Does it
force git-am to cherry-pick the patches?

-- Hannes
