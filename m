From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Wed, 23 Jun 2010 02:34:49 +0530
Message-ID: <AANLkTimIDet95GgvjyiQQPHSU2FSkJcC7WKv7fILiz-y@mail.gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
	<201006221311.05339.jnareb@gmail.com>
	<AANLkTim2qOENdcyjbYF8NNmEfMJ-ijhwQY-Pf46JWuiO@mail.gmail.com>
	<201006222229.17623.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 23:04:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORAeP-00068j-8R
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 23:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0FVVEv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 17:04:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56350 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab0FVVEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 17:04:50 -0400
Received: by gye5 with SMTP id 5so3192263gye.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=On18FYbeq5KomQyMcdyoGkw9STiSHYcaIhL9JEDHyXw=;
        b=cFOtQW3I13Z2AzTLwdkv/i/LwdjPdguhbSebzhaSsYbvRakqoKpYYBXiVgkkkaUBlo
         R9eQjyv4Up/As7kxZekDVCUMH5Fctduh+MtdLdW6Zis26nW7rnH8scYWO2xpGl3CaNQe
         bS7igOSuU4ju+7Vlwq4l8OkAqPMIGSf2yYpkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hh1GRC6o2s+tOOabjbVj56gKIhkqSYW0uVXaUbEgNTLCZ+gNa6FxrOHcvbT6iEduf4
         xTKKTTOCSB1D2PHhQszf7aU2jJYhhVU3QLhW7qv97e7+6vRYF+WYIX4ep9rCBh9xgXCd
         BpylDWwt0O5Al8NDI+k2RY1Sgqei/NajyWUK8=
Received: by 10.101.130.27 with SMTP id h27mr5420050ann.170.1277240689511; 
	Tue, 22 Jun 2010 14:04:49 -0700 (PDT)
Received: by 10.100.141.14 with HTTP; Tue, 22 Jun 2010 14:04:49 -0700 (PDT)
In-Reply-To: <201006222229.17623.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149493>

On Wed, Jun 23, 2010 at 1:59 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
>>
>> Yes, due to either unment dependency or circular dependency problem.
>> But no need to worry as they are very small.
>
> Could you _*LIST*_ those subroutines that you feel should belong in
> Gitweb::Config but could not be put in it, and write _why_ they could=
 not
> be put (on what subroutines / variables do they depend that it makes
> impossible to move them)?

feature_* subs. They can't be put in it because they use
git_get_project_config from Gitweb::RepoConfig module

>>>
>>> What unment dependencies? =A0Can it be worked around by changing th=
eir
>>> signatures to use additional parameters, e.g.:
>>>
>>> =A0sub validate_action {
>>> =A0 =A0 =A0 =A0my $input =3D shift || return undef;
>>> =A0 =A0 =A0 =A0my $actions =3D shift || return undef;
>>>
>>> =A0 =A0 =A0 =A0return undef unless exists $actions->{$input};
>>> =A0 =A0 =A0 =A0return $input;
>>> =A0}
>>
>> Yes. I think we can but don't you think that we need to import
>> %actions everytime we use validate_action.
>> So, I figured it would be better If i leave it untouched for now.
>
> Well, changing subroutines could be thought as being ot of scope of
> current series, which is about splitting gitweb and moving subroutine=
s to
> appripriate modules... unless it would be not possible because of
> circular dependencies problem (but I guess it is not the case,
> ultimately).
>
>>
>>> But I guess it would be very hard to do the same with validate_proj=
ect.
>>> Also such change might be out of scope for _this_ series.
>
> Perhaps it would be better then to move _all_ validate_* subroutines =
to
> separate Gitweb::Request::Validate module... unless they are used by =
some
> subroutine from Gitweb::Request.

or even better if we leave them untouched for now. (in gitweb.perl scri=
pt)
and move them later along with the evaluate_validate_params function

>>>>
>>>> Subroutines moved:
>>>> =A0 =A0 =A0 evaluate_uri
>>>> =A0 =A0 =A0 evaluate_query_params
>>>> =A0 =A0 =A0 validate_pathname
>>>> =A0 =A0 =A0 validate_refname
>>>
>>> I'm not completly sure if validate_* subroutines should be not sepa=
rate,
>>> as they do require more knowledge about setup, and about git reposi=
tories
>>> served, than the rest of Gitweb::Request subroutines...
>>
>> But they are being used in Gitweb::Request subroutines, so I include=
d
>> them in there.
>
> Which Gitweb::Request subroutine uses validate_* subroutines? =A0Neit=
her
> evaluate_uri, nor evaluate_query_params, nor evaluate_path_info uses
> them. =A0And evaluate_and_validate_params can be in Gitweb::Request::=
Validate.
>
> If there is circular dependency in reasoning given above, please expl=
ain
> it.
>
>>>> 6. gitweb: Create Gitweb::Escape module
>>>>
>>>> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
>>>> to store all the quoting/unquoting and escaping subroutines
>>>> regarding the gitweb.perl script.
>>>>
>>>> This module imports $fallback_encoding variable from
>>>> Gitweb::Config module to use it in sub 'to_utf8'
>>>>
>>>> Subroutines moved:
> [...]
>>>> =A0 =A0 =A0 unquote
>>>
>>> Shouldn't unquote be in Gitweb::Parse, as contrary to the rest of
>>> subroutines is is not about gitweb output escaping/quoting, but
>>> about processing (parsing) output of git commands? =A0Perhaps it
>>> could even be provate to Gitweb::Parse (i.e. not exported by
>>> default)...
>>
>> It would result in circular dependency. So, Escape module is best fo=
r
>> it's place.
>
> Errr... how? =A0If unquote is used only by subroutines in Gitweb::Par=
se
> (and I think it is), it could be local to Gitweb::Parse, not even
> exported (by default). =A0Please explain.

Oh! I didn't know that.
I will change it.

>>>> 7. gitweb: Create Gitweb::RepoConfig module
>>>>
>>>> Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfi=
g.pm'
>>>> to store and handle all the configuration and subroutines
>>>> related to a single repository regarding the gitweb.perl script.
>>>>
>>>> This module depend on several other modules like Git.pm,
>>>> Config.pm, Request.pm and Escape.pm.
>>>>
>>>> It also include subroutines regarding project_list and
>>>> it's handling.
>>>
>>> Why? =A0Is it to not have too many tiny modules, or is simply there=
 no
>>> single good place where to put this subroutine?
>>
>> There is no single good place. Anyhow, as they are regarding project
>> configuration, I thought it would be better place for it.
>
> O.K.
>
>>>> 8. gitweb: Create Gitweb::View module
>>>>
>>>> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
>>>> to store the subroutines related to the HTML output
>>>> for gitweb.
>>>
>>> I find that this module looks a bit like a collection of fairly unr=
elated
>>> subroutines at very different levels of abstractions.
>>>
>>> I guess that you don't want to split gitweb into too many modules,
>>> and splitting gitweb is more of one of steps to final goal of addin=
g
>>> write functionality to gitweb, rather than the goal in and of itsel=
f.
>>> Nevertheless it would be good to be able to immediately know from t=
he
>>> description of module what kind of subroutines should be there.
>
> Any comment on this, if you don't mind? =A0Even "I don't want to thin=
k more
> about better split" would be all right for me.

I don't want to think more about better split :)

>>>> This module depends on Git.pm, Config.pm, Request.pm,
>>>> Escape.pm and RepoConfig.pm. Some subroutines which
>>>> output HTML but are not included in this module due
>>>> to unmet dependencies.
>>>
>>> Which subroutines and what unmet dependencies?
>>
>> action specific HTML divs. They include format_* and parse_* subs.
>
> Thanks for this info. =A0It should be, IMHO, in the comit message.
>
> But... Shouldn't all format_* subs be in Gitweb::Format anyway?
> Shouldn't all parse_* subs be in Gitweb::Parse anyway? =A0Which of fo=
rmat_*
> and parse_* do you feel that belong here?

Yes. I think u misunderstood me.
Gitweb::parse and Gitweb::Formst depend on Gitweb::View.
So, action specific HTML divs can't be placed in Gitweb::View because
they depend on Gitweb::Format and Gitweb::parse.

I think it's better if they are in GitwebAction::* modules

>>>> 9. gitweb: Create Gitweb::Util module
>>>>
>>>> Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
>>>> to store the git utility subroutines related to gitweb.
>>>>
>>>> This module include subroutines in various categories
>>>> such as git utility subs invoking git commands, git
>>>> utility subs accessing git repository, mimetype related
>>>> subs and HTML output utility subs.
>>>>
>>>> Subroutines moved:
>>>> =A0 =A0 =A0 git_get_head_hash
> [...]
>>>> =A0 =A0 =A0 is_patch_split
>>>
>>> O.K.
>>>
>>>> =A0 =A0 =A0 run_highlighter
>>>
>>> _Perhaps_ with exception of this subroutine.
>>
>> Well. It was in the utility category in gitweb.perl script. So, I
>> added it in here without giving much thought.
>
> Well, it is good explanation. =A0All right, then.
>
>>>> 10. gitweb: Create Gitweb::Format module
>>>>
>>>> Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
>>>> to store the subroutines related to formatting of HTML
>>>> fragments required for gitweb.
>>>>
>>>> This module depends on Config.pm, View.pm, Escape.pm,
>>>> Util.pm and Request.pm. It mainly contain functions returning
>>>> short HTML fragments or transforming HTML fragments. Also
>>>> include subroutines regarding avatar formatting.
>>>
>>> Why it depends on Gitweb::View, and not the reverse? =A0I understan=
d why
>>> it depends on Gitweb::Config and Gitweb::Escape, and I guess it nee=
ds
>>> $cgi from Gitweb::Request (or is it something more?).
>>
>> $hash, $hash_parent also.
>
> Why it depends on Gitweb::View? =A0Is it because of ubiquitous and
> troublesome :-) die_error?
>
>>>> 11. gitweb: Create Gitweb::Parse module
>>>>
>>>> Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
>>>> to store the subroutines which related to parsing functions
>>>> required for gitweb.
>>>>
>>>> This module depends on Git.pm, Escape.pm, View.pm and Util.pm.
>>>
>>> Why it depends on Gitweb::View? =A0It is a strange dependency.
>>> I understand depending on Gitweb::Git to some extent, I'm not sure
>>> if we shouldn't simply move unescape to it instead of requiring
>>> Gitweb::Escape (unless there is more: to_utf8 perhaps?), and
>>> I understand that Gitweb::Util has some required subroutines.
>>
>> for die_error.
>
> Ah, I se that any run of git command is protected with
> 'or die_error(...)'. =A0Hmmm, not very good.
>
> Well, in the future we could think about decoupling Gitweb::Parse fro=
m
> other modules, but for now it should be enough to mention in commit
> message that Gitweb::Parse depends on Gitweb::View because of die_err=
or.
> Good for now. =A0O.K.
>
> Perhaps die_error should be in Gitweb::Carp? =A0But it neds git_heade=
r_html
> etc. anyway. =A0Ugh.
>
> --
> Jakub Narebski
> Poland
>

Thanks,
Pavan.
