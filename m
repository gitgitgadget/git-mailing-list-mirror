From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions
 API
Date: Fri, 12 Dec 2014 17:17:16 +0100
Message-ID: <548B150C.2090606@alum.mit.edu>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 12 17:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzSuF-0005WM-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 17:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934960AbaLLQRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 11:17:22 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61166 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934917AbaLLQRW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 11:17:22 -0500
X-AuditID: 1207440c-f79376d00000680a-ee-548b150f7363
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B1.3F.26634.F051B845; Fri, 12 Dec 2014 11:17:19 -0500 (EST)
Received: from [192.168.69.130] (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBCGHHA3008851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 11:17:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqMsv2h1isGm5hUXXlW4mi4beK8wW
	b28uYbTo7fvEarF5czuLA6vHzll32T0WbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7oyO
	jq9sBVsEKlYe6GVuYFzB28XIySEhYCKx6doaZghbTOLCvfVsXYxcHEIClxklfkxuYYVwzjJJ
	/Hm1DqyKV0Bb4vz+BewgNouAqsTy+y1sIDabgK7Eop5mJhBbVCBI4uSe6+wQ9YISJ2c+YQEZ
	JCLQyigxa99zsAZhgWCJrucfwIqEBJwkeqZvYAGxOQWcJRY3rQOzmQX0JHZc/8UKYctLNG+d
	zTyBkX8WkrmzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZI
	CPPsYPy2TuYQowAHoxIP74vUrhAh1sSy4srcQ4ySHExKorx3+LtDhPiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nw/o0CKudNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfAy
	iAANFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFZXwxMC5BUjxAe+VA2nmLCxJz
	gaIQracYFaXEedlBEgIgiYzSPLixsMT0ilEc6Eth3gnCQFU8wKQG1/0KaDAT0ODlWzpABpck
	IqSkGhj13TeYhB257DUra7978pScHYrf7zzsu2H3rvur+jT+nUf+Xik7otwxR9FFee4W34ta
	h4J2rfp91PRikWp4S/o76aPHltYvrYm1f7nwfGroh7ui1l23l1nuX/xG9liNQev+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261350>

On 12/06/2014 03:46 AM, Stefan Beller wrote:
> This goes on top of Michaels series. The idea of this series is make the
> reflogs being part of the transaction API, so it will be part of the contract
> of transaction_commit to either commit all the changes or none at all.
> 
> Currently when using the transaction API to change refs, also reflogs are changed.
> But the changes to the reflogs just happen as a side effect and not as part of
> the atomic part of changes we want to commit altogether.

Would you please explain why this patch series is still needed if my
"reflog_expire()" series is accepted?

reflog_expire() already has its own little transaction. Reflog
expiration never needs to be combined with other reference changes, so
there is no need for reflog expiration to be done via a ref_transaction.

ref_transaction_commit() already updates the reflog if necessary when a
reference is updated. That update is part of the containing
ref_transaction, because it is locked by the lock on the reference
itself at the beginning of the transaction and unlocked at the end of
the transaction [1]. It can't fail in normal circumstances because the
preconditions for the transaction have already been checked.

As far as I can tell, the only thing left to do is provide a substitute
for log_ref_setup() a.k.a. create_reflog() that can be triggered within
a transaction. In my opinion the easiest way to do that is to give
ref_transaction_update()'s flag parameter an additional option,
REF_CREATE_REFLOG, which forces the reference's reflog to be created if
it does not already exist.

What am I missing?

Michael

[1] The reflog updates are not atomic in the face of disk errors and
power outages and stuff, but neither are reference updates. In other
words, I think reflog updates in ref_transaction_commit() are done as
safely as reference updates, which is surely good enough for this
reference backend. Other reference backends can do a better job with
both while staying within the existing API.

-- 
Michael Haggerty
mhagger@alum.mit.edu
