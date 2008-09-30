From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 10:48:38 +0200
Message-ID: <200809301048.40046.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809300221.25094.jnareb@gmail.com> <cb7bb73a0809300105s24706d79hb40e147739ec6f05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:50:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkavs-0007KU-ET
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYI3Ist (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYI3Ist
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:48:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:46892 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYI3Iss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:48:48 -0400
Received: by ey-out-2122.google.com with SMTP id 6so702092eyi.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xKpiFRqYy+IX1jykEZnRFjh/Aynxc0vAMViUGlRkL3Y=;
        b=fMETCjkSmQQDx9XtQfbIVXTQLZhRnmcsxUjaGMCpNY4Sszfxj38JYSyMjehmGRpHIl
         RchoEuEqAg1/0mxXqKwF/+8xxmG34y5ti2OUoQofJlaZMtATIuTKeHtIgQ40q0cb58IO
         ffKjP9T+XBPo/FLuBvNrN25Ed6ISCrOxVOGi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=svijj+ty5s3gNsbZcQ2bgcl/HqwO//Vp1H3QUAqsJUEMoh39RNqx9vUW4s0EdaUXQ9
         ul6rVi+0tPwVGXH3dNduKXSUJ2C8/1PQIfcjjq6HjSuHcJMVdLs0W9OBujkiYU0Ngkw1
         Ci02FSD5/gArojQ9F1gcHyEJHI0kHALVDvkME=
Received: by 10.103.223.20 with SMTP id a20mr4589476mur.86.1222764526010;
        Tue, 30 Sep 2008 01:48:46 -0700 (PDT)
Received: from ?192.168.1.11? (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id i5sm6923686mue.11.2008.09.30.01.48.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 01:48:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809300105s24706d79hb40e147739ec6f05@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97083>

On Tue, 30 Sep 2008, Giuseppe Bilotta wrote:
> On Tue, Sep 30, 2008 at 2:21 AM, Jakub Narebski <jnareb@gmail.com> wrote:

[...]
>> Ah.  Now I understand.
>>
>> When creating code for href(..., -replay=>1), which by the way I thought
>> would be more useful than actually is, I have forgot that parameters to
>> gitweb could be passed in other way that through CGI parameters
>> (CGI query)[1].
>>
>> Using
>>
>>        $params{$name} = [ $cgi->param($symbol) ];
>>
>> is a cute hack, but it doesn't work for arguments passed via path_info
>> (was: project, hash_base and file_name; while now it is project, action,
>> hash_base (in full) and file_name).
[...]

>> The solution I thought about and abandoned in favor of this cute hack
>> was to have additional hash (in addition to %mapping), which would map
>> action names to references to variables holding the value for parameter.
[...]

>> I am talking there about the following solution:
>>
>>        my %action_vars = (
>>                project => \$project,
>>                action => \$action,
>>                # ...
>>                extra_options => \@extra_options,
>>        );
>>        # ...
>>        while (my ($name, $symbol) = each %mapping) {
>>                if (!exists $params{$name}) {
>>                          $params{$name} = ${$action_vars{$name}};
>>                }
>>        }
>>
>>
>> This avoids cure hack of (from your code)
>>
>>                } else {
>>                           no strict 'refs';
>>                           $params{$name} = $$name if $$name;
>>                }
>>
>> I think that gitweb should use single source, not CGI query parameters
>> or variable saving [sanitized] value.
> 
> The alternative I've been thinking about would be to have an
> %input_parameters hash that holds all input parameters regardless of
> hash; thus CGI query parameters and data extracted from PATH_INFO,
> presently, but also command line options in the future, or whatever
> else.
> 
> This is somewhat different from your %action_vars alternative, in the
> sense that it isolates _input_ data, whereas if I understand correctly
> the approach you suggest would isolate _output_ data (in the sense of
> data to be used during link creation and whatnot).
> 
> Presently, the gitweb code defines some $variables from the input
> parameters, and then overwrites them for output. Keeping the input
> stuff clearly separate from the output stuff would mean that any
> routine can retrieve the input data regardless of the subsequent
> mangling and without any need to make ad-hoc backups or other tricks.
> 
> So my proposal is that I implement this %input_params stuff as the
> first patch for the pathinfo series, and use %input_params all around
> where cgi parameters are used currently (of course, %input_params is
> initialized with the CGI parameters at first). The next patch would be
> the extraction of parameters from PATH_INFO. And thirdly the PATH_INFO
> URL generation (with or without the /-before-filename thing, at your
> preference)

I presume that you would want to replace for example $hash_base
everywhere by %input_params{'hash_base'}?


I can think of yet another solution, namely to abstract getting
parameters from CGI query string, from path_info, and possibly in the
future also from command line options, and use this mechanism in
the getting parameters and validation part.

The %params hash would be filled from CGI parameters by using simply
"%params = $cgi->Vars;", then added to in evaluate_path_info instead
of directly modifying global parameters variables.  The input validation
and dispatch part would be modified to use %params (taking care of
multivalued parameters as described in CGI(3pm)), like below:

  our $action = $params{'a'} || $params{'action'};
  if (defined $action) {
  	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
  		die_error(400, "Invalid action parameter");
  	}
  }

That is just for consideration: each approach has its advantages and
disadvantages.  Your proposal, as I understand it, is similar to the
way described in "Storing options in a hash" subsection of 
Getopt::Long(3pm) manpage.


Or we could just scrap and revert adding href(..., -replay=>1).
There is much trouble with getting it right and performing well,
and it is less useful than I thought (at least now).

-- 
Jakub Narebski
Poland
