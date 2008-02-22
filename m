From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip
 address for the signed certificate
Date: Fri, 22 Feb 2008 11:53:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802221149210.13958@yvahk3.pbagnpgbe.fr>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com> 
 <20080221064252.GA16036@glandium.org>  <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
  <20080221190954.GA24759@glandium.org> <e26d18e40802211727w4f7f5b37vc73a756f6b384289@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 11:54:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSVY5-0004do-BP
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 11:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbYBVKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 05:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbYBVKxp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 05:53:45 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:60792 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbYBVKxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 05:53:44 -0500
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m1MArdA2006739;
	Fri, 22 Feb 2008 11:53:39 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <e26d18e40802211727w4f7f5b37vc73a756f6b384289@mail.gmail.com>
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74716>

On Thu, 21 Feb 2008, Anatoly Yakovenko wrote:

> $ GIT_SSL_NO_VERIFY=1 GIT_CURL_VERBOSE=1 git clone
> https://aeyakovenko@127.0.0.1/git
>
> i get this as an error:
>
> error: SSL: certificate subject name 'localhost' does not match target
> host name '127.0.0.1' (curl_result = 51, http_code = 0, sha1 =
> 4590de71622f1a90f906413fd7f63d5553cd5f93)

That's the very problem Mike Hommey's recent patch addresses. Verifying a 
peer's certificate is done with two different libcurl options:

* VERIFYPEER verifies the server's certificate against a local CA cert bundle

* VERIFYHOST verifies that the name in the server certificate matches the host
   you're talking to

For this particular case, you can in fact also make it work by making sure the 
server's certificate has the IP address as a "subjectAltName".
