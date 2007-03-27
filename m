From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support filename prefix in git_patchset_body
Date: Tue, 27 Mar 2007 02:07:26 +0100
Message-ID: <200703270307.26589.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.18549.jnareb@gmail.com> <20070326205508.GC1128@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Mar 27 03:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW082-0005C1-CX
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 03:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbXC0BEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 21:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933887AbXC0BEm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 21:04:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:59789 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbXC0BEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 21:04:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1757382uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 18:04:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dCBbShMX+WxhqFPWTWwAGmegK1/CeGtz3bIEjqeMHa3vdXi67olsVU4I7b5lYiegMDf+zMc6i7JNQO37jBmGqSCvr/mq3t4MAfZVmE31JNsdxxRDnjVJS8IXd0+Nnjzi5/52CXmLghhskfishpzkPtyh59udvZOM6FchV5Nbyoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e0tlhfB7hT6JJBcaVL+yTT04D94Qwpiv3+voXQfA4RmNGExqDVB9pQggkjs5psKE8k63EoZTSKNWYE1OV2e8RWwcwQlaKLVhLQIahw/pj6U3nixmYcV1zVf8tIih1JHCvvmeSQZ3q+2NaDyvxgkI5LkekucVenZDSSyFqvfx3Vs=
Received: by 10.66.250.17 with SMTP id x17mr33959ugh.1174957462956;
        Mon, 26 Mar 2007 18:04:22 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm30374990mue.2007.03.26.18.04.20;
        Mon, 26 Mar 2007 18:04:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070326205508.GC1128@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43221>

Martin Koegler wrote:
> On Mon, Mar 26, 2007 at 06:12:18PM +0100, Jakub Narebski wrote:
>> On Sun, Mar 25, 2007, Martin Koegler wrote:
>>
>>> git_treediff supports comparing subdirectories. As the output of
>>> git-difftree is missing the path to the compared directories,
>>> the links in the output would be wrong.
>>> 
>>> The patch adds two new parameters to add the missing path prefix.
>> 
>> Wouldn't it be better to concatenate the two "path prefix" patches
>> together? They are about the same thing.
> 
> I thought, each patch would be more readable, I split them in logical
> separate units. Anyway, I'll combine them.

That was just a thought. If you think that separate patches would be
more readable, by all meens keep them splitted.

>>>  sub git_patchset_body {
>>> -	my ($fd, $difftree, $hash, $hash_parent) = @_;
>>> +	my ($fd, $difftree, $hash, $hash_parent, $file_name, $file_parent) = @_;
>>>  
>>>  	my $patch_idx = 0;
>>>  	my $patch_line;
>> 
>> I'd rather use $from_prefix, $to_prefix here, or $basedif_name,
>> $basedir_parent, or $dir_name, $dir_parent (my preference is to
>> $from_prefix, $to_prefix variables).
> 
> I'll switch to $to_prefix and $from_prefix.
> 
>> +	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
>> +	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
>> +	$to_prefix ||= $from_prefix;  # to allow to pass common prefix once
> 
> OK. But is not the 3 line useless, as $to_prefix is alway defined
> after the second line and you probable want $from_prefix ||=
> $to_prefix. This will cause problems, as I currently pass the root
> tree (=tree in commit object) as an missing file name parameter, as
> gitweb does not allow an empty file name.

Third line is not important, as it is you who control the calling
convention. Perhaps it should read:

+	$to_prefix = $from_prefix  if (!defined $to_prefix);

And it would be fairly easy to change gitweb to allow empty file name
parameters; simply change

	!validate_pathname($file_name)

to

	!defined validate_pathname($file_name)

(and similarly for $file_parent).

But I'd rather not change _CGI parameter_ (URI) convention that we set
'fp' (file parent) parameter *only* if it is different from 'f' (file
name). Otherwise we would introduce backwards incompatibile change,
with respect to bookmarks and old URI-s. Cool URI-s don't change...


BTW. "git rev-parse <tree-ish>:" == "git rev-parse <tree-ish>^{tree}"

> With an propagation logic, comparing a root tree with an sub tree will only
> work in one direction.
> 
> So I prefer to do not implement any automatic propagation between the
> two prefixes. 

Fine by me. It is just _internal_ call convention.
 
>> or something like that, or just modify $from{'file'} and $to{'file'}
>> 
>> 	$from{'file'} = (!defined $from_prefix ? '' : $from_prefix.'/') . $from{'file'};
>> 	$to{'file'}   = (!defined $to_prefix   ? '' : $to_prefix . '/') . $to{'file'};
>> 
>> just after setting $from{'file'} and $to{'file'}, although the second
>> solution would additionally add prefix to the shown patch body itself.
> 
> Modifing the paths before generating the links is a good idea. I'll
> look, where its useful.

Please examine consequences of this, and changes in the output if you
decide to go this way (IMHO bit simpler).

-- 
Jakub Narebski
Poland
