From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 17/17] rename_tmp_log(): on SCLD_VANISHED, retry
Date: Tue, 07 Jan 2014 11:50:01 +0100
Message-ID: <52CBDBD9.7020607@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu> <1389015935-21936-18-git-send-email-mhagger@alum.mit.edu> <xmqqtxdhhsyq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 11:50:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0UEg-0001pH-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 11:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbaAGKuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 05:50:08 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42435 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751106AbaAGKuG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 05:50:06 -0500
X-AuditID: 1207440c-b7f566d000004272-cc-52cbdbddb08d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B3.19.17010.DDBDBC25; Tue,  7 Jan 2014 05:50:05 -0500 (EST)
Received: from [192.168.69.148] (p57A25E76.dip0.t-ipconnect.de [87.162.94.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s07Ao2kR013758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 05:50:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <xmqqtxdhhsyq.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqHv39ukgg5NTFC26rnQzWTT0XmG2
	eHtzCaPF7mkL2BxYPHbOusvucfGSssfjiSdYPT5vkgtgieK2SUosKQvOTM/Tt0vgzmhr+slY
	MJOt4nz3OcYGxu8sXYycHBICJhKNl/8wQ9hiEhfurWcDsYUELjNKfGp27GLkArLPMUlcv7Ge
	HSTBK6Atsfh5O1AzBweLgKrEie/2IGE2AV2JRT3NTCC2qECQxKNDD6HKBSVOznwCtktEQE1i
	YtshsFZmgUKJG2+KQMLCAu4Sve8PMEOsWssosaxvI9gNnALWEtPXzGYGqZcQEJfoaQwCCTML
	6Ei863vADGHLS2x/O4d5AqPgLCTbZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XUO93MwSvdSU0k2MkBDn2cH4bZ3MIUYBDkYlHt4Xe08FCbEmlhVX5h5ilORgUhLl1b5xOkiI
	Lyk/pTIjsTgjvqg0J7X4EKMEB7OSCC8zSI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1
	tSC1CCYrw8GhJMH75xZQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoeuOLgfEL
	kuIB2st0G2RvcUFiLlAUovUUoy7HvC8fvjEKseTl56VKifOeA9khAFKUUZoHtwKW0F4xigN9
	LMx7C6SKB5gM4Sa9AlrCBLQkNO4UyJKSRISUVAOjfOLeH5lMVc5nE7v1dS/5MPKuXjEjPEzd
	y+Tbpka9OYwX66dLb563RKXEIC1Pu8lwjR7Txj2bDu12n9We8unU3xBNVdO/N3k2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240104>

On 01/06/2014 07:21 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If safe_create_leading_directories() fails because a file along the
>> path unexpectedly vanished, try again from the beginning.  Try at most
>> 3 times.
> 
> As the previous step bumped it from 3 to 4 without explanation, the
> above no longer reflects reality ;-)

Good catch.  The increment 3 -> 4 was because the first call to rename()
is optimistic, and can fail once even if there is no race.  I will
change the commit message of 16/17 to explain this point, and of 17/17
to match reality.

> The series mostly looked sane from a cursory read.
> 
> Will re-queue.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
