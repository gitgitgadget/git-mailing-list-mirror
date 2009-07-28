From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Mon, 27 Jul 2009 21:11:44 -0700
Message-ID: <4A6E7A80.9040809@gmail.com>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>  <7vfxcku13i.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de> <7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com> <alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Irving <irving@naml.us>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 06:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVe2j-0006aL-Td
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 06:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbZG1ELv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 00:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbZG1ELu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 00:11:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:29002 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZG1ELr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 00:11:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so995580rvb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Ff3dbsd03SXmHcQ5ILuBDEYhautBJieIeIYb5AyrkpI=;
        b=GNqaY6rSPyYwp1h61o9tWDXTVbnpt1vY5kuUm8Etvb5iY7wr65EAqrs7TUE87vkixF
         9FpdGAKc37W7dVnuanZBfr5uPQc4E6/0J9eQe87yj42AFOo4x1xgO1bTws0gBo7bSdOw
         CTh1y/V2azKHJuyDDFEeor5uYOiUxkknwAncw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=phnebDOoWsmaG8YUThj6TJEelubLKYi+dmFfUcm02d8xpHmzeHaPDRbqNfV5qr+5Op
         vHTws1QOj+DLZhLuzpyVXEcp85Kj/4keRcw/apxdlrjvJoH+Sb5Tq9KsB9o6e166/ITZ
         GPJmfoKxxCJTTLIEW6Fy1RZ5xsedfGm/PFgxQ=
Received: by 10.141.37.5 with SMTP id p5mr4394988rvj.110.1248754307440;
        Mon, 27 Jul 2009 21:11:47 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id c20sm5741668rvf.31.2009.07.27.21.11.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Jul 2009 21:11:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124210>

Johannes Schindelin wrote:
> There is an ugly solution:
>
> 		{ OPTION_NEGBIT, 0, "no-data", &no_data, NULL, NULL,
> 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
> 		{ OPTION_BIT, 0, "no-data", NULL, NULL,
> 			"Skip output of blob data",
> 			PARSE_OPT_NOARG, NULL, 1 },
>
> and there is a more elegant solution:
>
> [PATCH] parse-opt: optionally show "--no-" option string
>
> It is usually better to have positive options, to avoid confusing double
> negations.  However, sometimes it is desirable to show the negative option
> in the help.
>
> Introduce the flag PARSE_OPT_NEGHELP to do that.

Perhaps with this documentation throw in?

diff --git a/parse-options.h b/parse-options.h
index 90e577d..14162e9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -81,6 +81,9 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *                             (i.e. '<argh>') in the help message.
  *                             Useful for options with multiple parameters.
+ *   PARSE_OPT_NEGHELP: says that the long option should always be shown with
+ *                     the --no prefix in the usage message. Sometimes
+ *                     useful for users of OPTION_NEGBIT.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
