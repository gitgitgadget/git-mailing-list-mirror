From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/18] gitweb: Add show_warning() to display an immediate warning, with refresh
Date: Fri, 10 Dec 2010 15:10:15 +0100
Message-ID: <201012101510.16504.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3zksezbkm.fsf@localhost.localdomain> <4D01D902.1030102@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 15:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR3gJ-0008Hw-7J
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 15:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab0LJOKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 09:10:38 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:45635 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0LJOKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 09:10:37 -0500
Received: by fxm18 with SMTP id 18so3770170fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=62/ava3nOxYe4XbFFGh7eDeVXkx5UdrbNwuMMlEh+iw=;
        b=Gu1t32fSAIgjOCRzIiqBc3NmRfZ1x3xapk5iJXodO73eSVeUmHs/MYw04ZMEnBdhhr
         HITCtIi1nYCYniT5sgX+05zrBAFf8KoqAELhpQSSBTsUurQiiCID4LwLtfF7PA3iPLPe
         BZkkxt7Sqv6zGyZHsut+XBtXCF126s1qUJFpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YMgq35rcrMqFhZO3ADSK0GGWWp18JpMu3aEW+K7SAxYja6kvcuqXvyMBOwhVBCY7Xa
         ObjeoQdnWo3D+I2+/yMnYZXXscq0jhhk4JjexbpLL9CzoXAWFZJNDNJbjEurkucJKscj
         au8TH+NyyV0PxDh6Lu72o4qPt2vxjEEIcqPPg=
Received: by 10.223.86.206 with SMTP id t14mr952412fal.30.1291990236210;
        Fri, 10 Dec 2010 06:10:36 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id a2sm903631faw.22.2010.12.10.06.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 06:10:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D01D902.1030102@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163415>

On Fri, 10 Dec 2010, J.H. wrote:
> On 12/09/2010 05:01 PM, Jakub Narebski wrote:
>> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:
>> 
>>> die_error() is an immediate and abrupt action.  show_warning() more or less
>>> functions identically, except that the page generated doesn't use the
>>> gitweb header or footer (in case they are broken) and has an auto-refresh
>>> (10 seconds) built into it.
>> 
>> Why not use gitweb header/footer?  If they are broken, it should be
>> caught in git development.  If we don't se them, the show_warning()
>> output would look out of place.
> 
> The only other 'transient' style page, the 'Generating...' page doesn't
> use it, and I felt that since this was also transient, and only (likely)
> to be seen once it wasn't worth the header & footer.
> 
> That said I've added it back in, in v9.

Well, the contents and feel of show_warning() is more like die_error()
rather than "Generating..." page, so I feel that if die_error() conforms
to style of rest of gitweb pages, then show_warning() should too.
 
>>> +sub show_warning {
>>> +	$| = 1;
>> 
>>   +	local $| = 1;
>> 
>> $| is global variable, and otherwise you would turn autoflush for all
>> code, which would matter e.g. for FastCGI.
> 
> Since the execution exits immediately after, wouldn't FastCGI reset at
> that point, since execution of that thread has stopped?  Or does FastCGI
> retain everything as is across subsequent executions of a process?

Well, with exit(0) it is a moot point... but it is good habit to localize
punctation variables ($|, $/,)
 
>>> +<meta http-equiv="refresh" content="10"/>
>> 
>> Why 10 seconds?
> 
> Long enough to see the error, but not too long to be a nuisance.  Mainly
> just there to warn the admin that it did something automatic they may
> not have been expecting.

A comment if you please, then?
 
Hmmm... I guess there is no ned to make it configurable.

>>> +</head>
>>> +<body>
>>> +$warning
>>> +</body>
>>> +</html>
>>> +EOF
>>> +	exit(0);
>> 
>> "exit(0)" and not "goto DONE_GITWEB", or "goto DONE_REQUEST"?
> 
> DONE_REQUEST doesn't actually exist as a label,

Errr... DONE_REQUEST was introduced in

  [PATCH/RFC] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error
  Message-ID: <1290723308-21685-1-git-send-email-jnareb@gmail.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/162156


> the exit was used 
> partially for my lack of love for goto's, but mostly out of not
> realizing what that was calling back to (mainly for the excitement of
> things like PSGI and their ilk)


You would have to do more than that.  ModPerl::Registry that is used
for mod_perl support (which as deployment is I guess more widespread
than PSGI via wrapper using Plack::App::WrapCGI, or FastCGI deployment)
redefines 'exit' so that CGI scripts that use 'exit' to end request
keep working without need to restart worker at each request; for real
exit, for example from background process, you need to use CORE::exit.
See e.g. http://repo.or.cz/w/git/jnareb-git.git/commitdiff/8bd99a6d37cc
the ->_set_maybe_background() method.

> 
> I will change that that, but considering there are other locations where
> I do explicit exit's and those are actually inherent to the way the
> caching engine currently works, I might need to go take a look at what's
> going on with respect to multi-threaded items inside of PSGI and their
> like.  It's possible the caching engine doesn't actually work on those...

That would be a pity.  In my rewrite I tried to take into acount both
non-persistent (plain CGI, running as script) and persistent (mod_perl,
FastCGI, PSGI) web environments.

>>> +}
>>> +
>>>  sub isBinaryAction {
>>>  	my ($action) = @_;
>> 
>> Didn't you ran gitweb tests?
> 
> I did, they passed for me - for whatever reason my cache dir wasn't
> cleaned up, and stayed resident once it was created.

Hmmm... I wonder why new tests in t9502 and t9503 didn't pass for me...


P.S. I'll write separate email about problems with die_error, die-ing
and output caching.

-- 
Jakub Narebski
Poland
