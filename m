From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 00:28:27 -0700
Message-ID: <7v3avvy9yc.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2Zg-0006UH-Ep
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbXJ1H2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbXJ1H2d
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:46197 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbXJ1H2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:32 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1C9D9151705;
	Sun, 28 Oct 2007 03:28:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 88F25151703;
	Sun, 28 Oct 2007 03:28:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62528>

Steffen Prohaska <prohaska@zib.de> writes:

> "git rev-parse --symbolic" used to return the ref name as it was
> specified on the command line. This is changed to returning the
> full matched ref name, i.e. "git rev-parse --symbolic master"
> now typically returns "refs/heads/master".

This is to expose "dwim_ref" logic, so it might be a good idea
to introduce a new option --dwim-ref for this purpose.

	git rev-parse --symbolic master^2

is designed to give "master^2" or fail if "master" is not a
merge.  Similarly, you would diagnose a failure if somebody asks
to show

	git rev-parse --dwim-ref master~4

instead of giving "refs/heads/master~4".

> +static void show_rev(int type, const unsigned char *sha1, const char *name, const char* real_name)
> @@ -131,7 +133,7 @@ static void show_default(void)
>  
>  		def = NULL;
>  		if (!get_sha1(s, sha1)) {
> -			show_rev(NORMAL, sha1, s);
> +			show_rev(NORMAL, sha1, s, 0);

A null pointer constant in git sources is spelled "NULL" not "0".

> @@ -213,6 +215,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is = 0, verify = 0;
>  	unsigned char sha1[20];
> +	char* real_name = 0;

Pointer sign '*' in git sources go next to the name not the
type, as:

	char *real_name = NULL;
