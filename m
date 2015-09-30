From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-send-email.perl: Fixed sending of many/huge
 changes/patches
Date: Wed, 30 Sep 2015 10:32:15 +0200
Organization: gmx
Message-ID: <ffd8558da6af0b84d09808f00c979aaa@dscho.org>
References: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, juston.h.li@gmail.com,
	Stefan Agner <stefan@agner.ch>
To: Lars Wendler <polynomial-c@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 30 10:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhCoW-0001U3-7y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 10:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbbI3Icb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 04:32:31 -0400
Received: from mout-xforward.gmx.net ([82.165.159.41]:51230 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbbI3Ic2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 04:32:28 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LtUHA-1ahrca3Av6-010xHW; Wed, 30 Sep 2015 10:32:16
 +0200
In-Reply-To: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:XuVzGSEq5nyxD6mOLrQkDifX4aKpa30MvzanwB2nNyH2mTToyi4
 NcopWnGm0i6QB6odH6CYBYQbSeYMyDlJmwFNFJFDlWYUkYa96eVs/ywVsOyrzYbByozIq20
 mdn5anMrNnj3oiQslq3IMI49vs4NbpR8ZE9CJ+4H4ggKPJ4v13/gYtZ5ifXCCWZ0kI8GzQ2
 b9C7vygF/89+glX+Mxjhw==
X-UI-Out-Filterresults: junk:10;V01:K0:EQ4cziM+o6U=:8Yhz5CVJdBixprnwQ382IJM9
 HnYGhZwh4Ory5JzyTcK5NCb7kqotlpJT9+4Syo47GWrqRSnEwckGGSerR44VLm1yw2CPcQc1r
 S0BdJrlFpcjsJB0WNJ+vSHK4IwHoh3ah2CTIc8DEYa5YZkpjlvC1gdzqxGgbTm24fXIslbwIJ
 mZIDwDGsvoNZOuYkIW4GpxeaqNWo6QQHSHK+WbqgRPztZVYmAnbFNw0QWWqviAVHN3+BgWCKw
 5/5JFzjCa2ckaC3rGtd5hrzfPEoWerX2nBu52TD2KWGUVIfUIun9cimrqCRyzkETxZHivLeNg
 gpuotYqunlu2omYHmes2JAHgZDsElraCXyPO09UtnF2enxpu6I7yomhQtNFp43GGUYlI0C3rT
 hkwBqXsF7APv+NQD9Wc9fldR1CyQd4IIxtRRuGAMiQ+4YwJ6F6PzcjMQSkz5lEv92d5676xPT
 GEjRr2vwbgsFtehlh6cEGmSX/6h105yeFfrV4E+oU7xc/aYokwW0YFHaKw8v5yFL1IPUrZs8C
 5/+XIZrLUtPZv6x8AtqCiDB8gjpUV0HfXlAXhWyA+7UTX3tf5P94lr0xH1gwy+Z29vloM4E/9
 GgSSb76xEZKCO7GbRaWLgXeWekmu1psIGr1EU0u3fz8ZgbXRBvY2aDW5xVjbRR2r2lFyl5dIk
 sItJwsbcnsKAOWz1S7dcUDIepnDMgC0Hkx4I90yi5HpKEANRO134nR+oa7jnLSNRv7jRziJ1v
 0Azutxw/v9NKT/a/RU7jRcHBkGDsWOMqBXgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278842>

Hi Lars,

On 2015-09-30 09:26, Lars Wendler wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> Sometimes sending huge patches/commits fail with
> 
> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
> line 1320.
> 
> Running the command with --smtp-debug=1 yields to
> 
> Net::SMTP::SSL: Net::Cmd::datasend(): unexpected EOF on command channel:
> at /usr/lib/git-core/git-send-email line 1320.
> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
> line 1320.
> 
> Stefan described it in his mail like this:
> 
> It seems to me that there is a size limit, after cutting down the patch
> to ~16K, sending started to work. I cut it twice, once by removing lines
> from the head and once from the bottom, in both cases at the size of
> around 16K I could send the patch.
> 
> See also original report:
> http://permalink.gmane.org/gmane.comp.version-control.git/274569
> 
> Reported-by: Juston Li <juston.h.li@gmail.com>
> Tested-by: Markos Chandras <hwoarang@gentoo.org>
> Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
> ---

Very nice! Thank you,
Dscho
