From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [RFC PATCH 2/3] connect: group CONNECT_DIAG_URL handling code
Date: Fri, 29 Apr 2016 22:00:52 +0200
Message-ID: <632a7629-645b-43a7-abd7-fcbc35362f60@web.de>
References: <20160428232936.GA8663@glandium.org>
 <1461890625-23222-1-git-send-email-mh@glandium.org>
 <1461890625-23222-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:01:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awEbM-00072S-62
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbcD2UBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:01:20 -0400
Received: from mout.web.de ([212.227.15.4]:50424 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcD2UBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:01:19 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MZleQ-1bGdnA1dyo-00LYje; Fri, 29 Apr 2016 22:00:58
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1461890625-23222-2-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:U8fDucbG+SLjLhMqZbUprwKbdIJYXa+P3uaFv7M4UuXRbPjdgJR
 DnE/PwXpFDjSWPSd6vP8BS+dLzKgK86fKWuZ/guEhprufNh5Q1c9OR0b5XhHvHQEctj91dW
 Zuh8kyS8ajefdsl22YhQfB02Bjmac3OxTcfC++kunGZptagHrE54P5i6oxFiNmjR0qhihLt
 wpPXKOUl5G+/DMwvoC1Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:js7sjLaioos=:Th9JGAX3UUTiHB/IRXKqkA
 cAPp1As5ZXoUJTE+opmVXAa1x7vzaVQKupJkCEVCKSZYyAkR3+ghZYQ6PyCaNWNre9L4fVLeY
 S0jzMmVzwnUlkcqLupzy+tTzKyFVqkyM/74JlY+QIZkwWhajTCqOY/uLF9cKihGiOWmkkKgFU
 7TLYKsuJsXLuWut1uKMg68jsytLut4EF1n/3s1dhn8dS6yG6F5s9tjPLt8ORwbfQsAAB6Te2R
 p/tYdF+UfcyErTJJvgHl0MfMD/f8U9iZqv8uvVyne0xgmb5eQliEld7ZyJ4FXCenn84yNg+YT
 aVhJ1sXrja2MVE8YlTbBoWXGnBnEPSz7zTXV/jajxgvD9iKGXv5+2IfoqS7lm9//qTA/4RO/V
 z5KxR4n35qnhZhWRqbhhbs+qD2RkH3y551nK5CMSzWSSKW3crYPZUUjARh8i5OF8BAGWmFMPK
 v0jYGW1pva4Pasy/sKPCNUvhDyg5zzJHIIV/L3mN1+6/SENGw2tnlyddji22c4WvYSe/7cuij
 uavhXM05Z3/8Xs6xsUCZsa1rNc2XELqPyvc1Gxxj/nxlJy9AWv/z9iu6XzPYvPJfYMzpU/msO
 IjKDAbTNPZr9f1gL/s7hUmifiP2lJOS3KdzJPqcsm5xnolBYnTOieTECuDBANc1ylXsHaiSxa
 GMS/1W0m//sEY6FqevSWBcCZP1kBRHKQHxPB849qIMGaL4ATXtcBEMFl58okhpMKeadBzN/oP
 STISBmOpDkw9SdiD2j3i8KA6aPetSgaqYMNDbDvZMbmHrOtqZMNqATDfJ/lOno7Twga16ZMu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293048>

On 29.04.16 02:43, Mike Hommey wrote:
> get_host_and_port(&ssh_host, &port);
> +			if (!port)
> +				port = get_port(ssh_host);

I'm not sure, if this is an improvement or not.

The original intention was, to check what the parser did, before
going out to the external program (like ssh) or opening a socket.

Everything should be prepared, as if the action had been taken,
and in the last nanosecond we jump out and print what would have
been done.
(The nanosecond may depend on the CPU speed)

In any case, for SSH there should be only one line calling get_host_and_port(),
or get_port().

This is to check the complete logic path in test cases, as well as it allows
the user to check the URL, especially when using SSH.

Splitting the logic into a path where we just print and one, where
the connection is really made, looses "single point of truth" - we don't know
any longer, what we test or print for diag.
