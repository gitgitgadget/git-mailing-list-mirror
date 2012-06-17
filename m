From: lalebarde <l.alebarde@free.fr>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Sun, 17 Jun 2012 00:33:32 -0700 (PDT)
Message-ID: <1339918412381-7561644.post@n2.nabble.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <1335029110871-7487506.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 09:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg9zz-0006WE-72
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 09:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab2FQHdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 03:33:33 -0400
Received: from sam.nabble.com ([216.139.236.26]:57235 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab2FQHdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 03:33:32 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <l.alebarde@free.fr>)
	id 1Sg9zI-0008B8-EC
	for git@vger.kernel.org; Sun, 17 Jun 2012 00:33:32 -0700
In-Reply-To: <1335029110871-7487506.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200120>

Hi,
I am puzzled from the 
http://article.gmane.org/gmane.comp.version-control.git/113221
recommandation of Junio C Hamano , the maintainer of git, to not encrypt
files before pushing them :

Junio C Hamano wrote
> If your "clean" encrypts and "smudge" decrypts, it means you are refusing
> all the benifit git offers.

Junio C Hamano wrote
> the above config may appear to work
*So, does it work or not, or partially ? And if partially, what does not
work ?*

Another issue is the use of the cypher ECB by 
https://github.com/shadowhand/git-encrypt git-encrypt . 
http://stackoverflow.com/questions/1220751/how-to-choose-an-aes-encryption-mode-cbc-ecb-ctr-ocb-cfb
Some  argue it is bad (cf also 
http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Electronic_codebook_.28ECB.29
that ). 

So I made some experiments, tacking a 15Mb pdf :

/$ openssl enc -base64 -aes-256-ecb -S 1762851 -k a5G4juy64VVBgfq4
<Wiley.pdf >WileyE1
$ openssl enc -base64 -aes-256-ecb -S 1762851 -k a5G4juy64VVBgfq4 <Wiley.pdf
>WileyE2
$ md5sum WileyE1
d43058d8443777aea871350245d9865b  WileyE1
$ md5sum WileyE2
d43058d8443777aea871350245d9865b  WileyE2

$ openssl enc -base64 -aes-256-ofb -S 1762851 -k a5G4juy64VVBgfq4 <Wiley.pdf
>WileyE1
$ openssl enc -base64 -aes-256-ofb -S 1762851 -k a5G4juy64VVBgfq4 <Wiley.pdf
>WileyE2
503d82849ad53652268d1abdcfbce9de  WileyE1
503d82849ad53652268d1abdcfbce9de  WileyE2

$ openssl enc -base64 -aes-256-cbc -S 1762851 -k a5G4juy64VVBgfq4 <Wiley.pdf
>WileyE1
$ openssl enc -base64 -aes-256-cbc -S 1762851 -k a5G4juy64VVBgfq4 <Wiley.pdf
>WileyE2
e726431cbd9ff8780946ddfad775600a  WileyE1
e726431cbd9ff8780946ddfad775600a  WileyE2/

*As the hash are identical from one run to another, I don't understand why
we should stick to the ECB cypher.*

Can some one clarify the two points please ?


--
View this message in context: http://git.661346.n2.nabble.com/Transparently-encrypt-repository-contents-with-GPG-tp2470145p7561644.html
Sent from the git mailing list archive at Nabble.com.
