From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jun 2011, #05; Thu, 30)
Date: Sat, 02 Jul 2011 20:46:59 +0200
Message-ID: <4E0F67A3.2030001@web.de>
References: <7viprmq4sy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 20:47:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd5Df-0001Gq-Cf
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 20:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab1GBSrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 14:47:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34315 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1GBSrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 14:47:01 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 910A21A416CF6;
	Sat,  2 Jul 2011 20:46:59 +0200 (CEST)
Received: from [93.246.49.61] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qd5DX-0005JE-00; Sat, 02 Jul 2011 20:46:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7viprmq4sy.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/+MosJ6uY0PASrpapty1+heVCjb28LmkAXmdLA
	tF3ZaCfk2ylLWF6jMQW8lAjMCgnMEU6uOsgirnGEY0HmCKpxC3
	BjFO1jo+Zx2RJGKmcjqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176563>

Am 01.07.2011 01:26, schrieb Junio C Hamano:
> * jl/submodule-add-relurl-wo-upstream (2011-06-06) 3 commits
>  - submodule add: clean up duplicated code
>  - submodule add: allow relative repository path even when no url is set
>  - submodule add: test failure when url is not configured in superproject
> 
> When merged to pu, it seems to break 7610.

It looks like the merge conflict resolution of the changes in
"submodule add: clean up duplicated code" with those from
"submodule add: always initialize .git/config entry" in the
jc/submodule-sync-no-auto-vivify branch dropped a variable change.

When I apply this on top of pu, all tests run fine:

------ 8< -----
@@ -253,11 +253,11 @@ Use -f if you really want to add it." &&
 			'') git checkout -f -q ;;
 			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$path'")"
 	fi
-	git config submodule."$path".url "$url"
+	git config submodule."$path".url "$realrepo"

 	git add $force "$path" ||
 	die "$(eval_gettext "Failed to add submodule '\$path'")"

 	git config -f .gitmodules submodule."$path".path "$path" &&
