From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] git-compat-util: st_add4: work around gcc 4.2.x
 compiler crash
Date: Mon, 21 Mar 2016 18:46:22 +0100
Message-ID: <56F0336E.6000103@web.de>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
 <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>
To: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 18:47:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai3ux-0003iL-LT
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbcCURqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:46:54 -0400
Received: from mout.web.de ([212.227.15.4]:53762 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851AbcCURqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:46:53 -0400
Received: from macce.local ([93.222.57.173]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MVLY6-1aH8ou0sdq-00YlOi; Mon, 21 Mar 2016 18:46:26
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
X-Provags-ID: V03:K0:rFKFchKD4faKsu3juFxEJTnUh6rFntqnD4MbElwBX56uKYWpGY3
 E7U/rfaobS2Yddl+vnnWroSJu3UQeNuazTLkTnbutWfOVDLmW8oXRNfr017WYC+blIzRPuo
 ynBJikXlR/jOQOexqpQITh8pUVK5ltSi+CMBARSo2vvbdBm1guY+TPzjCFB6ONOaf8p/nqN
 VhxQ9HeCvJs639vn6gVhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PN8WqZFI6Dk=:ciJB8M/2Ft/+p/F/BUC8kh
 QiBVbuVZUh1Zj5tIbf/dE0mXFMEP0eZTK1hPSkRCADZ4HAsmvOOAojP9HKRpI012S6jFYiwo4
 QMx/IAz8YjIneBMYFXKjhT4i3gXwRqYGSlwpQxoef6QDePdQayeo4oDu2z2wFqh4znsQortj/
 kaiWtrYl6znMdRw+obDQx+WssztD2b2IB5oZ4LGlk/pZv8dKc3bUOODqUgvbMhx12ixiY532h
 x9FzWLCDo4PwDCDaxEaClhVriAAahvgDAq9GzZgP6JWz0bzKN0aqtE0NC9ViUnyWBxznwmi10
 GNIdlZK2Pf4kk4RhwPjgRdVK1W1ZY3vkcu9daE6BlIK1/g7gw+tp7SivfqwQDXtnIRyPDI7VO
 kj7+hFFxdGPfw8pzyH+cm+OchF10VXs3H0Bus4CJab060R2+t7+doobjP5IttEoiSWQc8VDfZ
 yuf6BV7/48NPk7El9U31NLZfDu1GWraqeDW2YcMShV9+/UtjBwp5pH+GfhKq4cHIb5GOqS1DL
 ThUEYmNePltVLRwTQ7a4yqxARY1z7kbBCpi16ljZDOyBFGwFKpcGUAZdG1IJCBG/dFGMKd8Ef
 dJp+9oSgkKXSNPwGaoCWGTd0N9qBDAfDtW4v9oTnQnSZEMRNDgW3BcLVlkHoLc4n6FlFulfuY
 WE0S515f1axzpby5sr8+bkK20SmUbtECw7W1C/xaM3wOk6mgAv5xxxJFxI6T9hJrPSFULerfD
 zYKb5k3dl5//Ewi+PeXMLbfFSJ9lIRp56XImvJ19GbB5zPOiF7QG1DX9NlqfnxdcQZcXgtQr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289427>

On 2016-03-21 05.35, Eric Sunshine wrote:
>  }
> -#define st_add3(a,b,c)   st_add((a),st_add((b),(c)))
> -#define st_add4(a,b,c,d) st_add((a),st_add3((b),(c),(d)))
> +#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
> +#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
>  

That fix compiles on my test machine,
and passes the test suite.
thanks for digging.
