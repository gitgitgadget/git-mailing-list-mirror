From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Fri, 16 Dec 2011 15:00:51 +0100
Message-ID: <4EEB4F13.2010402@viscovery.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 15:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbYLP-0004Bn-1F
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 15:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759443Ab1LPOA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 09:00:59 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61873 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756517Ab1LPOA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 09:00:57 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RbYLD-0003In-SH; Fri, 16 Dec 2011 15:00:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 891991660F;
	Fri, 16 Dec 2011 15:00:51 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111216110000.GA15676@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187278>

Am 12/16/2011 12:00, schrieb Jeff King:
>  static const char *builtin_attr[] = {
...
> +	"*.c diff=cpp",
> +	"*.cc diff=cpp",
> +	"*.cxx diff=cpp",
> +	"*.cpp diff=cpp",
> +	"*.h diff=cpp",
> +	"*.hpp diff=cpp",

Please don't do this. It would be a serious regression for C++ coders, and
some C coders as well. The built-in hunk header patterns are severly
broken and don't work well with C++ code. I know for sure that the
following are not recognized:

- template declarations, e.g. template<class T> func(T x);
- constructor definitionss, e.g. MyClass::MyClass()
- functions that return references, e.g. const string& func()
- function definitions along the GNU coding style, e.g.

     void
     the_func ()

I am currently using this pattern (but I'm sure it can be optimized) with
an appropriate xcpp attribute:

[diff "xcpp"]
        xfuncname = "!^[
\\t]*[a-zA-Z_][a-zA-Z_0-9]*[^()]*:[[:space:]]*$\n^[a-zA-Z_][a-zA-Z_0-9]*.*"

(modulo MUA line wrapping).

-- Hannes
