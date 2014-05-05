From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] Use ref transactions for fetch
Date: Mon, 05 May 2014 13:22:43 +0200
Message-ID: <53677483.4050409@alum.mit.edu>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhyJ-0005Yp-6x
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384AbaEELWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 07:22:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60683 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755451AbaEELWq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 07:22:46 -0400
X-AuditID: 1207440f-f79326d000003c9f-0a-536774855bd0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 87.02.15519.58477635; Mon,  5 May 2014 07:22:45 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB24B0.dip0.t-ipconnect.de [93.219.36.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s45BMhnn022079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 May 2014 07:22:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398192327-21302-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1G0tSQ82mD5D3KLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ3xb3s7c8EVnor3G56wNTDO4Opi5OSQEDCR2Pv8
	GjOELSZx4d56NhBbSOAyo8SXheZdjFxA9jkmiZm/jrGAJHgFtCVenlkHVsQioCqx7/NvVhCb
	TUBXYlFPM1MXIweHqECQxJ+zihDlghInZz4BaxURsJNYf2sh2C5hAXOJ2VMWQ+1ylpj/fw1Y
	nFPAReLhucWsIGMkBMQlehqDQMLMAjoS7/oeMEPY8hLb385hnsAoMAvJhllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyRA+Xcwdq2XOcQowMGoxMObwJwe
	LMSaWFZcmXuIUZKDSUmUd0s0UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb3YiUI43JbGyKrUo
	HyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJME7oRioUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UpfHFwDgFSfEA7d0H0s5bXJCYCxSFaD3FqMtxoWFFC5MQS15+XqqU
	OO9ekCIBkKKM0jy4FbB09IpRHOhjYd7JIFU8wFQGN+kV0BImoCVcxmBLShIRUlINjFM/KcTK
	ZdXdDuEXUI/4Wp4b9bD+g6nmg12HNISPneRa6rMtZJlV2r79n64fmVCSc4Dly+TqCd2svEcn
	hWtMvvF6W0m51/FWk4X7RZ4eNwyetyKvfF1IqfxfoU81TM67dsXMD306c/lyp0DZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248135>

On 04/22/2014 08:45 PM, Ronnie Sahlberg wrote:
> This change is based on the previous ref transaction patches.
> This is sent as a separate patch series since it implements a lot more
> non-trivial changes to the behaviour than the previous patches and thus can
> use more detailed review.
> 
> Update fetch.c to use ref transactions when performing updates. Use a single
> ref transaction for all updates and only commit the transaction if all other
> checks and oeprations have been successful. This makes the ref updates during
> a fetch (mostly) atomic.

Is this always an improvement?  What kind of checks are there that might
fail?

It would be pretty annoying to spend a lot of time fetching a big pack,
only to have the fetch fail because one reference out of many couldn't
be updated.  This would force the user to download the entire pack
again, whereas if the successful reference updates had been allowed,
then probably most or all of the second download would have been avoidable.

On the other hand, if a reference was renamed on the remote side,
allowing a partial reference update could cause history to be discarded
locally if the old name's delete was accepted but the new name's
addition was rejected.  This wouldn't be the end of the world, because
the history is presumably still available remotely to fetch again, but
it's not ideal either.

I'm not sure myself what I would prefer, but I wanted to point out that
it is IMO not obvious that atomicity here is an improvement.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
