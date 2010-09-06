From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 06 Sep 2010 22:12:38 +0200
Message-ID: <4C854B36.6010606@web.de>
References: <4C85357A.8090000@web.de> <20100906190655.GG25426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:12:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osi3b-0000RW-2S
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab0IFUMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:12:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:56718 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0IFUMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:12:40 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id DBB7D15EEF90F;
	Mon,  6 Sep 2010 22:12:38 +0200 (CEST)
Received: from [93.246.34.185] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Osi3S-0002Jl-00; Mon, 06 Sep 2010 22:12:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100906190655.GG25426@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Nsnv3+cWqT15JQ7KFLYa5IkiPyN1+ekzGdjFq
	QlxlCIZ5JpbXvpcNTQq0QRcYpsTzt5LbjWLfNp3adtfsfbLfPH
	PR9N4LAX8/zXqn8w4/6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155610>

Am 06.09.2010 21:06, schrieb Jonathan Nieder:
> Do you think it would be a bad idea if I send a follow-on patch that
> changes code like this:
> 
> 	(cd dir &&
>  	git update-index --add two &&
>  	case "`git ls-files`" in
>  	two) echo pass two ;;
>  	*) echo bad two; exit 1 ;;
> 	esac
> 	) &&
> 
> to this:
> 
> 	(
> 		cd dir &&
> 		git update-index --add two &&
> 		case "`git ls-files`" in
> 		two) echo pass two ;;
> 		*) echo bad two; exit 1 ;;
> 		esac
> 	)
> 
> It would have the benefit of touching all code in the subshell, so we
> could see the effect on "exit" commands and whatnot.

I think that makes a lot of sense. I think you would not only end up
changing the indentation of many subshells (not only those that I
added), you will also have to deal with tests using spaces instead of
tabs for indentation. But these issues have to be addressed anyway ...
