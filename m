From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 19:42:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301941170.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <5631AB75.5030800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEd4-0003hk-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793AbbJ3SmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:42:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:57315 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbbJ3SmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:42:18 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Lp3Lw-1aNz0q3BMi-00etmx;
 Fri, 30 Oct 2015 19:42:12 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <5631AB75.5030800@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ZJqvGhbrbNmP9+ayABSuBxrImavcpYtilOIdOc/8Y0ANgd6x0Jj
 kTAP2SUIA403NrU6yDWOYmZc2wqVO3tghdApLsrdYSe/6ENBZgvYD6/UAJLOo+ko5jfl9fL
 QcbbcNpaXMYHx+Uin+S3pRjflUPa1cK8ybc8x0jtY3csHQ7VP0HvWAXh1gBNvKGGQujo/mC
 ZgQxTkdQemPmhZwIKQTww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uYze9VyifoA=:5/5esmlJWYNeIiRkHJx2l3
 ya9Aqsm0EfBMKix0EdES5N4tY33MLfJCmjRIcGTdg3Mm1eAdHFx2+HsjTetVF6MgsF0bVM1Ge
 71//bfSEBPQYe+1NZyo+/cl+pAPofM4lT/jOEuG7mWjPSt178GAZ0YHrot5nLSKAynw7EWMuO
 WjsBx+CjlDg58BkxsA2xjdrTFUT76qOQcPOzTuucY0B6I1XdwBpfsaMiSvomp6mYWL7HdkLRc
 FlQAKZhTR9qonUdD7igQjPV3hwM+cKuetqgRSdv7a+YGRzs7VBBrlTMfHPrVqgfWJGYxEtpmC
 3RRyR2bvTcvs9qUSMri4GWrDL6gwk4Jo3FHVxfcqRC6lSeAoYzVClOH9/BtaPsngo2wN2OzGy
 3Jqpb7SH4i2I2lbQkGmXH8KOOC2ffcmpEStQ/PHUQpa5TwBJLeGS2NUYqpbQN6+UH7Z20i0Ry
 5wIzw3YWMaxXFMMHukPdgrr9LCcoM6eXRSvQyDMDrka6XcsZ+v5nIPsoqXnBQQ3WDOAgndMO2
 AZ0uW+zC2o2wxuea5TFrRQAXHkzcLsLnEkNL8E4ehT1whmH10NEUIuXcv/JeuOQHaMEP4ovBm
 xq1iKvdPUS3dwZ95xojTq8EXHQaVHPIfy2OtVWq8/V2ix26ni2zhyXtXCU1Pv1PNr8nqZkZNp
 RvH1CCFe5NgQlgxAHezdIS52pp7gy2yJ38Av2GlHkq2c1jUD5JVI9NKhjxOi48lOIfnzHLG31
 qqBirNICY3H58S5X9rri6JWJAGcttAlgTeENKoJH5sYXVSRnCd/R5VXT2Kih7IWYE4FCly3x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280518>

Hi Victor,

On Thu, 29 Oct 2015, Victor Leschuk wrote:

> >   +if test -n "$TEST_GDB_GIT"
> > +then
> > +	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> Maybe we could make $TEST_GDB_GIT not just a boolean flag? It would be useful
> to contain "gdb" executable name. It would allow to set path to GDB when it
> is not in $PATH, set different debuggers (for example, I usually use cgdb),
> or even set it to /path/to/gdb_wrapper.sh which could contain different gdb
> options and tunings.

Sure, as long as TEST_GDB_GIT=1 still works. Why don't you make an add-on
patch and submit it?

Ciao,
Johannes
