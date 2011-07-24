From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Ensure git ls-tree exits with a non-zero exit code
 if read_tree_recursive fails.
Date: Sun, 24 Jul 2011 15:42:06 +0200
Message-ID: <4E2C212E.8000404@web.de>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com> <1311469670-15392-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkywg-0003N7-LY
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab1GXNmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:42:10 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:58777 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1GXNmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:42:07 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 751F21A713009;
	Sun, 24 Jul 2011 15:42:06 +0200 (CEST)
Received: from [93.246.40.48] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QkywY-0002oq-00; Sun, 24 Jul 2011 15:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1311469670-15392-3-git-send-email-jon.seymour@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19FyZs7xdUirvAYHr/inmfCdVl5Sr2ligdY95fy
	5V+aMtT1GDqsUbiQT+GgKnyusdJqE0PRVX/bvQxw/gJzOmP7iT
	OL2Bi4QKhng+v/nTc3lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177749>

Am 24.07.2011 03:07, schrieb Jon Seymour:
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index f08c5b0..6d6c992 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -120,7 +120,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned char sha1[20];
>  	struct tree *tree;
> -	int i, full_tree = 0;
> +	int i, full_tree = 0, err;
>  	const struct option ls_tree_options[] = {
>  		OPT_BIT('d', NULL, &ls_options, "only show trees",
>  			LS_TREE_ONLY),
> @@ -173,7 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  	tree = parse_tree_indirect(sha1);
>  	if (!tree)
>  		die("not a tree object");
> -	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
> +	err = read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
>  
> -	return 0;
> +	return err;
>  }

Nit: Is it really necessary to introduce a new variable "err" for that? Looks
like a "return read_tree_recursive(...)" would suffice here ...
