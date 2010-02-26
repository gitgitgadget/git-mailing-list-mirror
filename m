From: Brent Payne <brent.payne@gmail.com>
Subject: Re: Fwd: gitweb trouble on fedora
Date: Fri, 26 Feb 2010 14:29:02 -0800
Message-ID: <f71da3d1002261429q219503c7l4e54db6e1fe7ae9f@mail.gmail.com>
References: <f71da3d1002261329o1ec140f0y9ad56a61b26ccbfc@mail.gmail.com>
	 <f71da3d1002261332s671d0010h7d196569ec8c911@mail.gmail.com>
	 <4B883F65.6050909@eaglescrag.net> <4B884109.9090509@eaglescrag.net>
	 <f71da3d1002261403h157b0829v71d61937e02dcc93@mail.gmail.com>
	 <f71da3d1002261406q2dcd117fxbb3b7faeaa18fbca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:29:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl8gL-0006fv-8s
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 23:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966459Ab0BZW3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 17:29:07 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:61737 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966450Ab0BZW3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 17:29:05 -0500
Received: by qyk9 with SMTP id 9so354926qyk.5
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 14:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y81+8c+UPE97gfORJMeNlwHP1PALf8taWR9wdk7xjHw=;
        b=tIb2zJKzjpog23+hSnNgP9miLFa4GfnPZNtnE5389jROnTJZ79C3Z3jB4t6R7R/IzZ
         lRJaAyLpuLsuokjAQCVAY44+JW8TKgNLCWMCAyd+MUiUQetc9BtXv04R4/F66umLzFGF
         QmumJSX/Wq/+w3opEmNafmq6C+4Vfj7bLkQuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vac1wEQQnYZdrRQtxZBlOQqyeMgISt5whFt9pDUIn7szYuPpYp9UiBN4zd+YC99367
         wx9jubZvRoEmy5Qe8UiRBdZNQJIY/0D6YwyPRV+Z7k9lvz8sAk0HA0ILQVwET4pNV1K8
         zqCOtMdMi3TW4wT6/FhOOZm2FheGtHCZqy3cY=
Received: by 10.229.88.147 with SMTP id a19mr492462qcm.92.1267223342558; Fri, 
	26 Feb 2010 14:29:02 -0800 (PST)
In-Reply-To: <f71da3d1002261406q2dcd117fxbb3b7faeaa18fbca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141157>

Thanks J.H,

I figured out the issue.  Fedora wants the git repos in /var/lib/git,
which isn't owned by apache, but somehow magically works with the
default yum install gitweb,  the default git.conf doesn't specify a
git.conf and all my attempt to change the datapath to /var/cache/git
or /pub/git failed with permission denied.

Restating fix, for others who google this problem:
#revert to fedora gitweb
sudo yum remove gitweb
sudo yum install gitweb
mv /path/your.git/ /var/lib/git/

Back to coding,
Brent

On Fri, Feb 26, 2010 at 2:06 PM, Brent Payne <brent.payne@gmail.com> wr=
ote:
> Okay, reinstalled gitweb, I don't get the permission error but I stil=
l
> get a 404 Not Found
> [bpayne@hg git]$ wget http://localhost/git
> --2010-02-26 14:06:26-- =A0http://localhost/git
> Resolving localhost... 127.0.0.1
> Connecting to localhost|127.0.0.1|:80... connected.
> HTTP request sent, awaiting response... 301 Moved Permanently
> Location: http://localhost/git/ [following]
> --2010-02-26 14:06:26-- =A0http://localhost/git/
> Connecting to localhost|127.0.0.1|:80... connected.
> HTTP request sent, awaiting response... 404 Not Found
> 2010-02-26 14:06:26 ERROR 404: Not Found.
>
> apache error log, doesn't list anything, just standard restart info:
> [Fri Feb 26 14:04:11 2010] [notice] caught SIGTERM, shutting down
> [Fri Feb 26 14:04:11 2010] [notice] SELinux policy enabled; httpd
> running as context unconfined_u:system_r:httpd_t:s0
> [Fri Feb 26 14:04:11 2010] [notice] suEXEC mechanism enabled (wrapper=
:
> /usr/sbin/suexec)
> [Fri Feb 26 14:04:11 2010] [notice] Digest: generating secret for
> digest authentication ...
> [Fri Feb 26 14:04:11 2010] [notice] Digest: done
> [Fri Feb 26 14:04:11 2010] [warn] ./mod_dnssd.c: No services found to=
 register
> [Fri Feb 26 14:04:11 2010] [notice] Apache/2.2.14 (Unix) DAV/2
> PHP/5.3.1 configured -- resuming normal operations
>
>
> On Fri, Feb 26, 2010 at 2:03 PM, Brent Payne <brent.payne@gmail.com> =
wrote:
>> I pulled and made gitweb.cfg from git://git.kernel.org/pub/scm/git/g=
it.git
>> i first tried the fedora yum install gitweb
>> and I've tried both /pub/git and /var/cache/git, the later is used i=
n
>> some online tutorials. =A0I've tried both with apache owning each
>> folder. =A0I've tried a lot of different tweaks, but it seems to be
>> something to do with permissions but I currently have apache:apache =
as
>> the owner of /var/cache/git
>>
>> this is my current /etc/gitweb.config
>> # path to git projects (<project>.git)
>> $projectroot =3D "/var/cache/git";
>> # directory to use for temp files
>> $git_temp =3D "/tmp";
>> # target of the home link on top of all pages
>> $home_link =3D "/git/";
>> # html text to include at home page
>> $home_text =3D "indextext.html";
>> # file with project list; by default, simply scan the projectroot di=
r.
>> $projects_list =3D $projectroot;
>> # stylesheet to use
>> $stylesheet =3D "gitweb.css";
>> # logo to use
>> $logo =3D "git-logo.png";
>> # the 'favicon'
>> $favicon =3D "git-favicon.png";
>>
>>
>>
>>
>> this is my current /etc/init.d/httpd/conf.d/git.conf:
>>
>> Alias /gitweb-data /var/cache/git
>> ScriptAlias /git /var/www/cgi-bin/gitweb.cgi
>> <Directory /var/www/cgi-bin/>
>> =A0Options FollowSymLinks ExecCGI
>> =A0AllowOverride None
>> =A0Order allow,deny
>> =A0Allow from all
>> =A0DirectoryIndex gitweb.cgi
>> </Directory>
>>
>> should I start over and reinstall the fedora gitweb? get back to a
>> known state. =A0Pretty sure I get the same error, but I'll do that.
>>
>> Thanks,
>> Brent
>>
>>
>> On Fri, Feb 26, 2010 at 1:45 PM, J.H. <warthog19@eaglescrag.net> wro=
te:
>>> Errr let me back that up - my gitweb-caching package in fedora does=
n't
>>> make reference to /var/cache/git at all - where is the code your tr=
ying
>>> to run coming from? =A0Which iteration of the caching code are you =
using,
>>> is it mainline, Jakub's, mine, fedora's? =A0Some additional informa=
tion
>>> would be helpful.
>>>
>>> - John 'Warthog9' Hawley
>>>
>>> On 02/26/2010 01:38 PM, J.H. wrote:
>>>> Brent,
>>>>
>>>> Make sure that /var/cache/git is owned by apache. =A0I assume your=
 using
>>>> gitweb-caching as opposed to gitweb on fedora. =A0This is a fedora=
 bug
>>>> though and should be filed on bugzilla.redhat.com
>>>>
>>>> - John 'Warthog9' Hawley
>>>>
>>>> On 02/26/2010 01:32 PM, Brent Payne wrote:
>>>>> plain text version
>>>>>
>>>>> ---------- Forwarded message ----------
>>>>> From: Brent Payne <brent.payne@gmail.com>
>>>>> Date: Fri, Feb 26, 2010 at 1:29 PM
>>>>> Subject: gitweb trouble on fedora
>>>>> To: git@vger.kernel.org
>>>>>
>>>>>
>>>>> I'm new to about everything, but I've hit my head on the wall for=
 a
>>>>> couple of hours, went through the gitweb README and INSTALL, onli=
ne
>>>>> tutorial, everything.
>>>>>
>>>>> I am having trouble getting gitweb running on a fedora box with a=
pache.
>>>>>
>>>>> The apache error is
>>>>> [Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
>>>>> 13:21:25 2010] gitweb.cgi: Can't opendir(/var/cache/git): Permiss=
ion
>>>>> denied
>>>>> [Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
>>>>> 13:21:25 2010] gitweb.cgi: =A0at /var/www/cgi-bin/gitweb.cgi line=
 2432
>>>>>
>>>>>
>>>>> Can anyone guess at what I'm doing wrong?
>>>>>
>>>>> Thanks,
>>>>> Brent
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>>
>>
>
