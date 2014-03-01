From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Sat, 01 Mar 2014 01:19:32 +0100
Message-ID: <53112794.2070007@alum.mit.edu>
References: <53108650.2020708@alum.mit.edu> <xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 01:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJXeX-0004wP-Hr
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 01:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaCAATh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 19:19:37 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48029 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752036AbaCAATg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 19:19:36 -0500
X-AuditID: 1207440d-f79d86d0000043db-cb-53112797e09f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F6.41.17371.79721135; Fri, 28 Feb 2014 19:19:35 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s210JXwr030075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 19:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqDtdXTDY4OsEG4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE748yCpcwFL6UqJnzbxdjA+Fiki5GDQ0LAROLo
	Y7kuRk4gU0ziwr31bF2MXBxCApcZJZYd2ckK4Zxjkli87hUbSBWvgLbE6/8f2UGaWQRUJa4d
	CwEJswnoSizqaWYCsUUFgiVWX37AAlEuKHFy5hMwW0RATWJi2yEWkFZmoPqHbxJBwsICphKT
	Tjayg9hCAlESD5duYgIp4RSwllh/NQ7iSnGJnsYgkApmAR2Jd30PmCFseYntb+cwT2AUnIVk
	1ywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERK2vDsY/6+T
	OcQowMGoxMN7YL5AsBBrYllxZe4hRkkOJiVR3o0cgsFCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHgnXAcq501JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8K5QAxoqWJSa
	nlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rc+GJg7IKkeID2vgNp5y0uSMwFikK0nmLU
	5bjd9usToxBLXn5eqpQ47z9VoCIBkKKM0jy4FbAk9YpRHOhjYd43IKN4gAkObtIroCVMQEta
	9oM8V1ySiJCSamBUZZp2lV1i3emtt1bMkJh2i/3+Seer6+8+rNpzSVfrWHxV8wK/OnnXCK/k
	lytNxffzp8maZukxbsrZdSR9kuFZJY/Nf2/nzkm9J2Nz3Hhn+8yzj6vuLnZ7cFdt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243032>

On 02/28/2014 09:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I just wrote up another double-idea that has been stewing in my head for
>> a while:
>>
>> * Allow configuration values to be unset via a config file
>> * Fix "git config --unset" to clean up detritus from sections that are
>> left empty.
> 
> The former is *way* too large for a GSoC project.  Most
> configuration variables are meant to be read sequencially and affect
> in-core variables directly, like
> 
>         /* file-scope global */
> 	static int frotz = -1;  /* unset */
> 
>         static int parse_config_frotz(const char *key, const char *value, void *cb)
> 	{
>         	if (!strcmp(key, "core.frotz"))
>                 	frotz = git_config_int(value);
> 		return 0;
> 	}
> 
> 	... and somewhere ...
>         	git_config(parse_config_frotz, NULL);
> 
> The config parsers are distributed and there is no single registry
> that knows how in-core variables owned by each subsystem represent
> an "unset" value.  In the above example, -1 is such a sentinel
> value, but in some other contexts, the subsystem may choose to use
> INT_MAX.  The only way to allow "resetting to previous" is to
> 
>  (1) come up with a way to pass "this key is being reset to
>      'unspecified'" to existing git_config() callback functions
>      (like parse_config_frotz() in the above illustration), which
>      may or may not involve changing the function signature of the
>      callbacks;
> 
>  (2) go through all the git_config() callback functions and make
>      them understand the new "reset to 'unspecified'" convention.

I absolutely understand that changing all of the config parsers is not
feasible.  But I had imagined a third route:

(3) parse the config once, storing the raw values to records in
    memory.  When an "unset" is seen, delete any previous records that
    have accumulated for that key.  After the whole config has been
    read, iterate through the records, feeding the surviving values
    into the callback in the order they were originally read (minus
    deletions).

Do you see any problems with this way of implementing the functionality
(aside from slightly increased overhead)?

And once we have a way to store config records in memory, it might also
make sense to reuse the parsed values for later config inquiries (after
checking that the files have not changed since the last read).  After
this second step the net performance change might even be advantageous.

> which may not sound too bad at the first glance (especially, the
> first one is almost trivial).
> 
> But the side effects these callbacks may cause are not limited to
> setting a simple scaler variable (like 'frotz' in the illustration)
> but would include things that are hard to undo once done
> (e.g. calling a set-up function with a lot of side effects).
> 
> The latter, on the other hand, should be a change that is of a
> fairly limited scope, and would be a good fit for a GSoC project
> (incidentally, it has been one of the items on my leftover-bits list
> http://git-blame.blogspot.com/p/leftover-bits.html for quite some
> time).

But only the latter part would be a bit meager as a GSoC project, don't
you think?

Thanks for the feedback.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
