From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related subroutines
Date: Sat, 12 Jul 2008 14:35:48 +0200
Message-ID: <200807121435.49151.jnareb@gmail.com>
References: <200807031824.55958.jnareb@gmail.com> <200807100133.38163.jnareb@gmail.com> <20080712014708.GB10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 12 14:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHeLZ-0006m3-L3
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 14:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYGLMgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 08:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYGLMgF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 08:36:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:11891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYGLMgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 08:36:03 -0400
Received: by ug-out-1314.google.com with SMTP id h2so51142ugf.16
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Zz5lMTiPeOLAIm3QaKrrgvi4hls7I6kXnvmh4KJyk7g=;
        b=DnyXcUo6pYz9T2KkXoAlsTGnUTwVdv6vk1a1XsNw98eluiBZP/ZyckJH95UoUIlYRi
         +p2513wGmumzd2zKp7MfKCn6AgHjhQeydAj4YHD+UhlJdwuwpmPkitnhGTtVOXv2b9iS
         M0kivsGOXrt7gJQZl+Spd+QeGfVdLiyx5FL2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ia32J3nztj/YeH/RgwNcFFNbpUN3JJeWRWcSXrabbmj6S0hVojpaPaiNzMerfGWPY6
         2HWt19IKBjl2LVIaNtDwnShdvB8SxSA1x0s40u84zlvor+uYdEN9aiw7/qwaXNK67waK
         mq4qHj85985VLWLH6pZjmzQMZhgft16Kxj2Fw=
Received: by 10.103.226.20 with SMTP id d20mr6253479mur.10.1215866161104;
        Sat, 12 Jul 2008 05:36:01 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.111])
        by mx.google.com with ESMTPS id u26sm3884199mug.4.2008.07.12.05.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 05:35:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080712014708.GB10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88238>

On Sat, Jul 12, 2008, Petr Baudis wrote:
> On Thu, Jul 10, 2008 at 01:33:36AM +0200, Jakub Narebski wrote:
>> On Wed, Jul 09, 2008, Petr "Pasky" Baudis wrote:
>>> On Thu, Jul 03, 2008 at 06:24:53PM +0200, Jakub Narebski wrote:

>>>>  * What should ->get_config() have as an optional parameter:
>>>>    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?
>>> 
>>> Do we even _need_ a parameter like that? I don't understand what is
>>> this interface trying to address.
>> 
>> For example if one wants to access _all_ variables in gitweb.* section
>> (or in gitcvs.* section), and _only_ config variables in given section.
> 
> But what is the practical benefit? Does anyone use a config file long
> enough that this makes any difference?

Probably not.

> Or if you mean foreach use, it's trivial to
> 
> 	foreach (grep { /^gitweb\./ } keys %$config)
> 
> or provide a method of Git::Config that will return this list, but it
> does not seem appropriate to have specific Git::Config instances for
> this. (Besides, if the script also needs to access a single variable
> from a different section, it will need to re-parse the config again.)
> 
> So I think your approach would be good only if there are multiple
> methods of Git::Config that would operate on the whole config and needed
> a way to be restricted; is that the case?

On the other hand if one uses (assuming now Git::Config object API)

  $conf = $repo->get_config('section');

one could access configuration variable values _without_ prefixing
them with subsection name, i.e.

  $conf->get('variable');

and not

  $conf->get('section.variable');


I'm not sure if it is much of an improvement.

>> BTW. what should non-typecasting should be named? $c->get(<VAR>), 
>> $c->value(<VAR>), $c->param(<VAR>), or something yet different?
> 
> I would prefer 'get' since it's the shortest and most clear, but 'value'
> would be fine too, I suppose (and more in line with bool etc.).

Well, that would have to be decided before other programs could use
this API.
 
We can have $c->value(<VAR>), $c->bool(<VAR>), $c->int(<VAR>) and
(in the future) $c->color(<VAR>) and $c->colorbool(<VAR>)... or we can
have $c->get(<VAR>), $c->get_bool(<VAR>) etc.

The former plays better with

  $r->get_config()->bool('gitweb.blame');

but this is nevertheless not recommended workflow; you can use

  $r->config_bool('gitweb.blame');

and it would be faster (unless some Perl/OO trickery with singletons
and the like).  Recommended workflow (code) is

  $c = $r->get_config();
  ...
  $c->get_bool('gitweb.blame');

or something like that.

>>> Also, having accessors for special types lets you return undef when
>>> the type really isn't defined, instead of e.g. true with current
>>> config_val_bool, which is clearly bogus and requires complicated code
>>> on the user side. 
>>  
>> I don't follow you.  Didn't we agree on casting an error when variable
>> is not of given type?
> 
> Sorry, s/type really/variable really/. According to your original code,
> 
> 	config_val_bool(undef)
> 
> would return true, while the undef could be from both non-existent and
> unassigned variable. (This 'unassigned variables' case is really
> annoying to handle.)

That is why you should check exists($config{<VAR>}) first.

-- 
Jakub Narebski
Poland
