From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 06/10] log: --function-name pickaxe
Date: Thu, 03 Apr 2014 23:25:05 +0200
Message-ID: <533DD1B1.3000107@web.de>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu> <62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, "David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 23:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVp9I-0007vp-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 23:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbaDCV0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2014 17:26:09 -0400
Received: from mout.web.de ([212.227.15.3]:60799 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbaDCV0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 17:26:06 -0400
Received: from [192.168.178.27] ([79.253.164.132]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LxqwW-1X88UF2RZU-015Fln; Thu, 03 Apr 2014 23:25:43
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
X-Provags-ID: V03:K0:ZRLLmI8UcSqn37gfXLmuP0BC3qMrZVuOVdWNf0APPArmw50tHgB
 FpQ6UiXZDpZxlT0+uXuzpP2g9pZzuBxqcMWJ3AsoAIHyfK4PNJ1Ryaf4YD0zctfs1jvo1GN
 CwBbisUPUn23r5YZqnUAQfxuJWnafEv0bsJCxGLSbTXZkIrP7iW62gOHnGOvFaxLAex0KJL
 2i50RMqmK5zk4J0Bb5Scg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245753>

Am 27.03.2014 19:50, schrieb David A. Dalrymple (and Bhushan G. Lodha):
> From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>
>
> This is similar to the pickaxe grep option (-G), but applies the
> provided regex only to diff hunk headers, thereby showing only those
> commits which affect a "function" with a definition line matching the
> pattern. These are "functions" in the same sense as with
> --function-context, i.e., they may be classes, structs, etc. dependin=
g
> on the programming-language-specific pattern specified by the "diff"
> attribute in .gitattributes.

With that approach you depend on the hunk header and apparently need to=
=20
add XDL_EMIT_MOREFUNCNAMES and XDL_EMIT_MOREHUNKHEADS to improve the=20
results.  This approach feels fragile.

Would it perhaps be more robust to not base the implementation on diff=20
and instead to scan the raw file contents?  You'd search both files for=
=20
a matching function signature, then search for a non-matching one from=20
there.  The parts in between are function bodies and can be compared.=20
If they match, you'd search for matching function starts again etc.

Or would it make sense to make use of the diff option FUNCCONTEXT (git=20
diff -W) and look for the function signature in the diff body instead o=
f=20
in the hunk header?  Such a diff contains whole functions, but a single=
=20
hunk could contain multiple ones.

Ren=E9
