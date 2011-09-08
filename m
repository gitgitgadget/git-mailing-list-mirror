From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 20:14:04 +0300
Message-ID: <4E68F7DC.9010303@unixsol.org>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org> <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com> <vpq7h5jtngj.fsf@bauges.imag.fr> <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com> <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com> <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com> <vpq39g7gua3.fsf@bauges.imag.fr> <4E68CA0C.5080702@unixsol.org> <4E68CC08.4040201@unixsol.org> <m37h5jt19v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1o3O-0002Eo-PD
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab1IHXaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:30:11 -0400
Received: from ns.unixsol.org ([193.110.159.2]:52679 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269Ab1IHXaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:30:06 -0400
Received: from gfmac.local ([::ffff:93.152.172.30])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with esmtp; Thu, 08 Sep 2011 20:14:04 +0300
  id 00140B8E.4E68F7DC.00004295
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <m37h5jt19v.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181004>

On 9/8/11 8:10 PM, Jakub Narebski wrote:
> Georgi Chorbadzhiyski<gf@unixsol.org>  writes:
>> Around 09/08/2011 04:58 PM, Georgi Chorbadzhiyski scribbled:
> [...]
>>> In order for this to work, confirmation should be split from send_message()
>>> and from a quick look this not seem very easy. Might be easier to just
>>> disable the sleep if user was asked for confirmation. It'll be good to
>>> not sleep after last email, but main "foreach my $t (@files) {" loop should
>>> pass some hint to send_message().
>>
>> The attached patch (apply on on top of the original) should implement the
>> idea.
>>
>> --
>> Georgi Chorbadzhiyski
>> http://georgi.unixsol.org/
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 7239fd4..d4559c9 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1149,7 +1149,7 @@ X-Mailer: git-send-email $gitversion
>>   		}
>>   	}
>>
>> -	if (!$dry_run&&  $sleep) {
>> +	if (!$dry_run&&  $sleep&&  $message_num<  scalar $#files&&  $confirm eq 'never') {
>                                                    ^^^^^^^^^^^^^^
>
>>   		print "Sleeping: $sleep second(s).\n" if (!$quiet);
>>   		sleep($sleep);
>>   	};
>
> Errr... what?  If we have @files array, then '$#files' is index of
> last element in array, which is scalar anyway, and 'scalar $#files' is
> a no-op.
>
> You can get number of elements in array with 'scalar @files', though
> _implicit_ scalar context would also work, like e.g. right hand side
> of '<' operator.

Correct, my perl is rusty and I wasn't sure $#xx was what I needed so
so I copied it from "$time = time - scalar $#files;" somewhere in
the same file.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
