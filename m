From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/27] update_refs(): Fix constness
Date: Tue, 01 Apr 2014 00:16:40 +0200
Message-ID: <5339E948.4090109@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-7-git-send-email-mhagger@alum.mit.edu> <xmqqha6e3v44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:17:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkVo-0005EH-17
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbaCaWQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:16:50 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:65426 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbaCaWQp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 18:16:45 -0400
X-AuditID: 12074411-f79ab6d000002f0e-6f-5339e94c2980
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 02.33.12046.C49E9335; Mon, 31 Mar 2014 18:16:44 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VMGelF015026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 18:16:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqha6e3v44.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqOvz0jLYYM9XTYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZ1zduZim4xFlxbaddA+NF9i5GTg4JAROJRxtus0LYYhIX7q1n62Lk
	4hASuMwo8XRbNxOEc5ZJYvr/I2AdvALaEvOuPmUBsVkEVCX+X+oCi7MJ6Eos6mlmArFFBYIk
	Dm84xQpRLyhxcuYTsHoRATWJiW2HWECGMgusZpRYOmUGG0hCWMBKovkGzLY1jBLzT10B6+AU
	sJZYt+oY0CQOoPvEJXoag0DCzAI6Eu/6HjBD2PIS29/OYZ7AKDgLyb5ZSMpmISlbwMi8ilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkHgR3MM44KXeIUYCDUYmH17LcMliI
	NbGsuDL3EKMkB5OSKO/Dx0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxbFwDleFMSK6tSi/Jh
	UtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvJUvgBoFi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQTEcXwyMYpAUD9DeaJB23uKCxFygKETrKUZdjg3b1jQyCbHk5eelSonz
	tjwHKhIAKcoozYNbAUt+rxjFgT4W5rUFGcUDTJxwk14BLWECWuJWZAaypCQRISXVwLgruCks
	05kj9vyXONkFyxT6q1ZcDV9fVbJi2zS2mBlajTxJR5lmpey5U3RMLcTvwuot8/pb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245557>

On 03/31/2014 11:40 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Since full const correctness is beyond the ability of C's type system,
>> just put the const where it doesn't do any harm.  A (struct ref_update
>> **) can be passed to a (struct ref_update * const *) argument, but not
>> to a (const struct ref_update **) argument.
> 
> Sounds good, but next time please try not to break lines inside a
> single typename, which is somewhat unreadable ;-)
> 
> I'd suggest rewording "s/Fix/tighten/".  Because a patch that
> changes constness can loosen constness to make things more correct,
> "git shortlog" output that says if it is tightening or loosening
> would be more informative than the one that says that it is "fixing".

It is not a strict tightening, because I add a "const" in one place but
remove it from another:

    const struct ref_update **

becomes

    struct ref_update * const *

in the update_refs() signature.  In fact, the old declaration was too
strict for some changes later in the patch series, which is why I needed
to loosen (one aspect) of it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
