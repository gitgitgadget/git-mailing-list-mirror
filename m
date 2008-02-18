From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Sun, 17 Feb 2008 21:08:17 -0800
Message-ID: <7vodaeua0u.fsf@gitster.siamese.dyndns.org>
References: <20080217205252.ff7ea434.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pascal Obry <pascal@obry.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 06:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQyFb-0006bI-DK
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 06:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYBRFIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 00:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbYBRFIg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 00:08:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYBRFIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 00:08:35 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0986FC0;
	Mon, 18 Feb 2008 00:08:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 5D8A26FB5; Mon, 18 Feb 2008 00:08:20 -0500 (EST)
In-Reply-To: <20080217205252.ff7ea434.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 17 Feb 2008 20:52:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74230>

Christian Couder <chriscool@tuxfamily.org> writes:

>  static void show_man_page(const char *git_cmd)
>  {
>  	const char *page = cmd_to_page(git_cmd);
>  	setup_man_path();
> -	execlp("man", "man", page, NULL);
> +	if (!man_viewer || !strcmp(man_viewer, "man"))
> +		execlp("man", "man", page, NULL);
> +	if (!strcmp(man_viewer, "woman"))
> +		exec_woman_emacs(page);
> +	if (!strcmp(man_viewer, "konqueror"))
> +		exec_man_konqueror(page);
> +	die("'%s': unsupported man viewer.", man_viewer);
>  }

I have to wonder if it makes sense to just define the interface
to launch an external user-supplied command, and have that
command line determine what actually should happen, e.g. inspect
DISPLAY and check emacs version etc.
