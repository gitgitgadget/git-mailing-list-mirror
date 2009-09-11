From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: check given hash before trying to create snapshot
Date: Fri, 11 Sep 2009 18:42:34 +0200
Message-ID: <200909111842.36465.jnareb@gmail.com>
References: <4AA96DAF.4070200@mailservices.uwaterloo.ca> <200909110952.50536.jnareb@gmail.com> <9513F576-4154-4281-8545-81841D59B766@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm9D7-0000h3-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 18:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZIKQmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 12:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZIKQmm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 12:42:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43130 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZIKQml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 12:42:41 -0400
Received: by bwz19 with SMTP id 19so908380bwz.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=x9rlkY+bxIJZQ9rNxIzkGXAc6Z9BL/BeI1PzmEz+1d0=;
        b=Wf8l4NRGcFr1FFMMdsoxVWxacrL7hXaSinI5wdLOiNyBHFse3VQ1/dSwPlOO7o3n2e
         tvDHBQ7ghmMAsPPeTlaLuhm01aAVCSzMnH0dVxTLEemfvOBoqAMue9hRb7KNlIW29GBY
         Qz7hmW95ACTTkqPRPPbcr5sktJYto7ibFfnBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oZJxhbaRRS7xkO1V/dt5VGZwmFmXMA4AUQjXT4XucNakjD3pMunF+k8wOkHhnx8zzw
         5Z1wyJ+9kZqvMJ+Zm4M0k3EirTHKklXRhpVdZpoVZQ9OtOZjt3Ncgsu2zg8rDwcRhbk0
         Hp8+UaWzbKw1Q+PomKGwrGEiQ39nPO+Sj12/U=
Received: by 10.204.154.154 with SMTP id o26mr2215250bkw.107.1252687363010;
        Fri, 11 Sep 2009 09:42:43 -0700 (PDT)
Received: from ?192.168.1.13? (abwd62.neoplus.adsl.tpnet.pl [83.8.227.62])
        by mx.google.com with ESMTPS id 31sm1750243fkt.53.2009.09.11.09.42.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 09:42:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9513F576-4154-4281-8545-81841D59B766@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128205>

[This mail was very strangely wrapped; I fixed this for readability]

On Fri, 11 Sep 2009, Mark Rada wrote:
> On 2009-09-11, at 3:52 AM, Jakub Narebski wrote:
> 
>> Second, I'd rather have better names for snapshots than using full  SHA-1.
>> For snapshot of 'v1.5.0' of repository 'repo.git' I'd prefer for snapshot
>> to be named 'repo-v1.5.0', and for snapshot of 'next' branch of the  
>> same project to be named for example 'repo-next-20090909', or perhaps
>> 'repo-next-2009-09-10T09:16:18' or 'repo-next-20090909-g5f6b0ff',
>> or 'repo-v1.6.5-rc0-164-g5f6b0ff'.
> 
> Ah, yeah, well, I let $hash still hold the originally passed value,  
> which would be used to create the outputted file name (unless
> overwritten by the client by using curl -o or something).

Or by specifying different file name than proposed by browser.

> Then $snapshot holds the full hash. This way, if you were to type
> something like 
> 
> http://git.kernel.org/?p=git/git.git;a=snapshot;h=next;sf=tgz
> 
> into your browser window, you would get git.git-next.tar.gz back, but  
> the backend could look up something like
> 
> git-5f6b0ffff13f5cd762d0a5a4e1c4dede58e8a537.tar.gz
> 
> using the $snapshot variable in some hypothetical cache (or even  
> without the cache it won't mangle the nicer name $hash might have).

O.K.

> 
> Also, right now gitweb will not accept tags for hashes. This seems to be
> because it passes the --verify option to rev-parse, but the output  
> from using and not using the verify option seems to be the same (other
> than also accepting all tree-ishes). Could you let me know if there is
> a good reason not to take off the --verify option? Otherwise, I would
> like to take it off in the next version of this patch.

Errr, what?

  $ 5096:[gitweb/web@git]# git rev-parse --verify v1.5.0            
  6db027ffe03210324939b3dd655c4223ca023b45
  $ git rev-parse --verify refs/tags/v1.5.0
  6db027ffe03210324939b3dd655c4223ca023b45

So it works as intended.  The problem must be in some other place.

The '--verify' option is needed because git-rev-parse would otherwise
pass parameters it does not understand 'as is'.  Compare

  $ git rev-parse --verify v9.9.9  2>/dev/null

  $ git rev-parse          v9.9.9  2>/dev/null
  v9.9.9

> 
> Your point about adding the short hash to snapshots of branch heads is
> cool, I'll try that for the next version of the patch.

I think it would be better left for a _separate_ patch, as it is
separate feature (and I guess more complicated one).

>>> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501- 
>>> gitweb-standalone-http-status.sh
>>> index d0ff21d..4f8f147 100644
>>> --- a/t/t9501-gitweb-standalone-http-status.sh
>>> +++ b/t/t9501-gitweb-standalone-http-status.sh
>>> @@ -75,4 +75,30 @@ test_expect_success \
>>> test_debug 'cat gitweb.output'
>>>
>>>
>>> +test_expect_success \
>>> +	'snapshots: bad treeish id' \
>>> +	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
>>> +	grep "400 - Not a valid hash id:" gitweb.output'
>>> +test_debug 'cat gitweb.output'
>>> +
>>> +test_expect_success \
>>> +	'snapshots: good treeish id' \
>>> +	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
>>> +	grep "Status: 200 OK" gitweb.output'
>>> +test_debug 'cat gitweb.output'
>>
>> Why you don't check for "Status: 400" too?
> 
> I'm not sure which test you are referring to (I think the second). The
> second test is valid and should return a nice .git-master.tar.gz
> tarball.

The output of CGI script like gitweb (and therefore gitweb.output file,
as it is generated now) contains both HTTP headers, separated by single
empty CRLF delimited line from the proper output of a script.

In first test you check that _contents_ contain specific error message,
but you do not check if HTTP status code matches it (it should, because
of how die_error works).  In second test you check HTTP status.  If the
t/t9501-gitweb-standalone-http-status.sh is to be about status, I guess
that you should check HTTP status, and not contents of the page (which
is more likely to change, e.g. due to some prettifying).

In t9501 tests you need, I think, only the HTTP headers part, unless
you want also to check that the contents matches.  There was some sed
script shown to extract only HTTP headers.
 
>>> Second, any given treeish will always be translated to the full length,
>>> unambiguous, hash id; this will be useful for things like creating
>>> unique names for snapshot caches.
>>
>> But this is not a good idea, IMHO.
>>
>> First, it introduces feature that nobody uses (at least yet); we can
>> introduce this feature when it is needed instead.
> 
> Sorry for promoting vapourware, I did originally rip this patch out from
> something else. I removed the comment from the v2 commit message.

Ah. O.K. then.

-- 
Jakub Narebski
Poland
