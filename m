From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: All gnupg tests broken on el4 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 14:11:05 +0100
Message-ID: <54CA3169.4020701@statsbiblioteket.dk>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 14:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGosP-0004tr-4T
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 14:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbbA2NLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 08:11:11 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:3249 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428AbbA2NLH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2015 08:11:07 -0500
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Thu, 29 Jan 2015 14:11:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263146>

On 28/01/15 00:35, Junio C Hamano wrote:
> A release candidate Git v2.3.0-rc2 is now available for testing
> at the usual places.
>

All signed commit tests fail on RHEL4 which is a regression from 2.2.2.

 From t4202.42:

++ git tag -s -m signed_tag_msg signed_tag
gpg: key CDDE430D: secret key without public key - skipped
gpg: skipped `C O Mitter <committer@example.com>': secret key not available
gpg: signing failed: secret key not available
error: gpg failed to sign the data
error: unable to sign the tag
error: last command exited with $?=128

There are indeed no public keys available after commit 1e3eef which 
seems to be contrary to the commit log:
----
    Instead import public and secret keys for one key pair from a text
    file that holds ASCII-armored export of them.
----

I extracted the pubkeys as ascii armored text from the old binary 
keyrings and added them to the new keyring.gpg and then the tests pass.

This is apparently only a problem for older gnupg versions (RHEL4 has 
gnupg 1.2.6) since it did not fail on RHEL5 (gnupg 1.4.5).

-tgc
