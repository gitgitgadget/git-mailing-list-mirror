From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/33] peel_ref(): fix return value for non-peelable,
 not-current reference
Date: Tue, 16 Apr 2013 11:38:00 +0200
Message-ID: <516D1BF8.9030009@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-14-git-send-email-mhagger@alum.mit.edu> <7va9ozwv70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US2S0-0006jr-0k
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab3DPJpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:45:07 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45210 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab3DPJpG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 05:45:06 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2013 05:45:05 EDT
X-AuditID: 1207440d-b7fd06d000000905-bf-516d1bfa05d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 65.24.02309.AFB1D615; Tue, 16 Apr 2013 05:38:02 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3G9c0HO019068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 05:38:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7va9ozwv70.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqPtLOjfQ4FOftEXXlW4mi4beK8wW
	Kx/fZbb40dLD7MDi0f7+HbPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsejiPpaC
	NewVE26sYWxg/MPaxcjJISFgIvG0ey4zhC0mceHeerYuRi4OIYHLjBIfp09ghnCOM0ksvPmC
	BaSKV0Bb4uT8NUwgNouAqsTf/efYQGw2AV2JRT3NYHFRgTCJVeuXMUPUC0qcnPkErFdEQE1i
	YtshIJuDg1kgRuLcVSGQsLBAosT0/Vugdq1glLh+/jXYdZwCZhJ//rSA9TIL6Ei863vADGHL
	S2x/O4d5AqPALCQrZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU
	0k2MkIDm3cH4f53MIUYBDkYlHt5A+ZxAIdbEsuLK3EOMkhxMSqK8VlK5gUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeNWXA5XzpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4
	lCR4TYCRKyRYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitX4YmC0gqR4gPa6gbTz
	Fhck5gJFIVpPMepyrLzy5DWjEEtefl6qlDivOEiRAEhRRmke3ApY+nrFKA70sTBvDkgVDzD1
	wU16BbSECWjJgVXZIEtKEhFSUg2MQst+NAjML5bO6HH6JdL+36tq2pX3IYF3vvxey/d3n2fv
	sf9vPRzermhbtTpjU3bivJJHk401qn3FetNla2S71AsfT9vWeN1kQnbyS+kOf4XP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221402>

On 04/15/2013 07:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The old version was inconsistent: when a reference was
>> REF_KNOWS_PEELED but with a null peeled value, it returned non-zero
>> for the current reference but zero for other references.  Change the
>> behavior for non-current references to match that of current_ref,
>> which is what callers expect.  Document the behavior.
>>
>> Current callers did not trigger the previously-buggy behavior.
> 
> Is that because we were lucky by codeflow, or is it just that we
> didn't have a testcase to trigger the behaviour?

Existing callers only called peel_ref() from within a for_each_ref-style
iteration and only for the current ref.  Therefore the buggy code path
was impossible to reach.

I will note that in the commit message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
