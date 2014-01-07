From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 13/17] remove_dir_recurse(): handle disappearing files
 and directories
Date: Tue, 07 Jan 2014 11:07:17 +0100
Message-ID: <52CBD1D5.5080701@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu> <1389015935-21936-14-git-send-email-mhagger@alum.mit.edu> <xmqqy52tht2l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 11:14:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Tg8-0008Ce-JH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 11:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbaAGKO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 05:14:27 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62473 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbaAGKOY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 05:14:24 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2014 05:14:24 EST
X-AuditID: 12074411-b7f426d000005455-23-52cbd1da2cb3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.D6.21589.AD1DBC25; Tue,  7 Jan 2014 05:07:22 -0500 (EST)
Received: from [192.168.69.148] (p57A25E76.dip0.t-ipconnect.de [87.162.94.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s07A7IFm012088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 05:07:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <xmqqy52tht2l.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqHvr4ukggzfzJS26rnQzWTT0XmG2
	eHtzCaPF7mkL2BxYPHbOusvucfGSssfjiSdYPT5vkgtgieK2SUosKQvOTM/Tt0vgzvj+ZhNj
	wV+xioNzdjI1MG4W6mLk5JAQMJF4vngVO4QtJnHh3nq2LkYuDiGBy4wSU9YtB0sICZxjkji0
	JAjE5hXQlpjx6wJQnIODRUBVYsNrQ5Awm4CuxKKeZiYQW1QgSOLRoYfsEOWCEidnPmEBsUUE
	1CQmth1iAWllFiiUuPGmCCQsLBAvsefbZ3aItWsZJRac/cYIkuAUsJZo/bKKCaReQkBcoqcR
	7AJmAR2Jd30PmCFseYntb+cwT2AUnIVk2ywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyY
	l5dapGuql5tZopeaUrqJERLigjsYZ5yUO8QowMGoxMP7Yu+pICHWxLLiytxDjJIcTEqivDK7
	TgcJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG9sxEox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCe
	WJKanZpakFoEk5Xh4FCS4JUHxrKQYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCh6
	44uB8QuS4gHaGw/SzltckJgLFIVoPcWoyzHvy4dvjEIsefl5qVLivMogRQIgRRmleXArYAnt
	FaM40MfCvDYgVTzAZAg36RXQEiagJaFxp0CWlCQipKQaGGuWp1s1+W1dqebNeWXXGsXP3Tnb
	ej9GF/6d+VZgdWiRuekGz9YU0co7nHW72n823V25VlH9k+yT5CK5qYtNpgrXupkH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240102>

On 01/06/2014 07:18 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If a file or directory that we are trying to remove disappears (e.g.,
>> because another process has pruned it), do not consider it an error.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  dir.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 11e1520..716b613 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1476,7 +1476,9 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>>  	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
>>  	dir = opendir(path->buf);
>>  	if (!dir) {
>> -		if (errno == EACCES && !keep_toplevel)
>> +		if (errno == ENOENT)
>> +			return keep_toplevel ? -1 : 0;
> 
> If we were told that "foo/bar must go, but do not bother removing
> foo/", is it an error if foo itself did not exist?  I think this
> step does not change the behaviour from the original (we used to say
> "oh, we were told to keep_toplevel, and the top-level cannot be read
> for whatever reason, so it is an error"), but because this series is
> giving us a finer grained error diagnosis, we may want to think
> about it further, perhaps as a follow-up.

Indeed, this is a design choice that I should have explained.  I
implemented it this way to keep the behavior the same as the old code in
this situation, and because I thought that if the caller explicitly asks
for the toplevel path to be kept, and that path doesn't even exist at
the entrance to the function, then something is screwy and it is better
to return an error than to keep going.

It would even be possible to argue that if keep_toplevel is set but path
is missing, then this function should call
safe_create_leading_directories(path).

Changing this behavior would require an audit to see which behavior
would be most useful to the callers.  I think that is out of the scope
of this patch series.

> I also wonder why the keep-toplevel logic is in this "recurse" part
> of the callchain. If everything in "foo/bar/" can be removed but
> "foo/bar/" is unreadable, it is OK, when opendir("foo/bar") failed
> with EACCESS, to attempt to rmdir("foo/bar") whether we were told
> not to attempt removing "foo/", no?
> 
>> +		else if (errno == EACCES && !keep_toplevel)
> 
> That is, I am wondering why this part just checks !keep_toplevel,
> not
> 
> 	(!keep_toplevel || has_dir_separator(path->buf))
> 
> or something.

I'm not sure I understand your point.  Please note that the
REMOVE_DIR_KEEP_TOPLEVEL bit is cleared from flags before this function
recurses.  So in recursive invocations, keep_toplevel will always be
false, and the rmdir(path->buf) codepath will be permitted.  Does that
answer your question?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
