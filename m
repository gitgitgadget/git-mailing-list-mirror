From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Use start_comand() in builtin-fetch-pack.c instead of explicit fork/exec.
Date: Thu, 04 Oct 2007 01:55:12 -0700
Message-ID: <7v8x6jb6of.fsf@gitster.siamese.dyndns.org>
References: <200709302340.17644.johannes.sixt@telecom.at>
	<1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
	<1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
	<1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
	<1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>
	<1191442180-15905-5-git-send-email-johannes.sixt@telecom.at>
	<1191442180-15905-6-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:55:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMUT-00030w-IF
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbXJDIzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 04:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXJDIzV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:55:21 -0400
Received: from rune.pobox.com ([208.210.124.79]:37416 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbXJDIzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:55:20 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id ECA9914186A;
	Thu,  4 Oct 2007 04:55:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 57A74141857;
	Thu,  4 Oct 2007 04:55:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59934>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  fetch-pack.c |   35 ++++++++++-------------------------
>  1 files changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index d06b5ec..80268e1 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -502,9 +503,12 @@ static int get_pack(int xd[2])
>  	char hdr_arg[256];
>  	const char **av;
>  	int do_keep = keep_pack;
> +	struct child_process cmd;
>  
>  	side_pid = setup_sideband(fd, xd);
>  
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.argv = argv;
>  	av = argv;
>  	*hdr_arg = 0;
>  	if (unpack_limit) {

Your patch to this function makes status and pid unused
variables, which I've fixed up locally.

The tip of your topic is currently queued to the tip of 'pu';
there were quite severe merge conflicts (textual conflicts in
builtin-fetch-pack.c, and adjustment to transport.c for
semantics change was also needed), so I ended up doing an evil
merge there, which I am not very happy about.

I suspect the evil-merge's changes to builtin-fetch-pack to
handle the connection to the index-pack process may be quite
busted, but I ran out of time.  Please check if the result makes
sense, Ok?

I think Daniel and Shawn's git-fetch-in-C should graduate
'master' before this series.  If you can re-send the series
rebased on 2b5a06edca8f7237aad6464b349b79772024d2a2 (Restore
default verbosity for http fetches.), it would be much
appreciated.
