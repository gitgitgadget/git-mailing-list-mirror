From: dhruva <dhruva@ymail.com>
Subject: Fw: PATCH: git-p4 optional handling of RCS keywords [was: Re: git-p4 and keyword expansion]
Date: Wed, 10 Sep 2008 10:50:30 +0530 (IST)
Message-ID: <972463.79535.qm@web95005.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: GIT SCM <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 07:28:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdIFd-0003Ax-Fz
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 07:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbYIJF1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 01:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbYIJF1Q
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 01:27:16 -0400
Received: from n5b.bullet.mail.tp2.yahoo.com ([203.188.202.117]:47317 "HELO
	n5b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751464AbYIJF1Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 01:27:16 -0400
Received: from [203.188.202.76] by n5.bullet.mail.tp2.yahoo.com with NNFMP; 10 Sep 2008 05:27:14 -0000
Received: from [202.43.196.224] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 10 Sep 2008 05:27:14 -0000
Received: from [203.212.168.61] by t1.bullet.tpe.yahoo.com with NNFMP; 10 Sep 2008 05:27:14 -0000
Received: from [203.104.18.50] by t2.bullet.kr1.yahoo.com with NNFMP; 10 Sep 2008 05:27:13 -0000
Received: from [127.0.0.1] by omp111.mail.in2.yahoo.com with NNFMP; 10 Sep 2008 05:27:12 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 385981.50518.bm@omp111.mail.in2.yahoo.com
Received: (qmail 80978 invoked by uid 60001); 10 Sep 2008 05:20:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=hNWx4azUSADOVbNPyjsVWGxRRMFPSQzXHKFvpPspMcCSbzvFx3G7tAcvuAMFrz/Oj6+lhagRpLtzfQ6llgcguDfIQZAqcUOqTcSN4xzQhS9ObPfmYKbrdCP2kiPLIFdrY7hg2+QZBVhoRonQkmnNRHiQeeG++uf5e/8z6nVyzNg=;
X-YMail-OSG: ReZTuS4VM1mdVe3m5rYewITyACpBJt.9lkxNBrTlSXejgMgzZRCsZ5Ai3BCtE0JIFlvHG_ZVOdVPBKkAl_NPYB9SJZgnmWGuOmuqdRYn_jBp.SIXEwlQnff6XkjS8mM-
Received: from [202.3.112.9] by web95005.mail.in2.yahoo.com via HTTP; Wed, 10 Sep 2008 10:50:30 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95481>

For some reason, my mail did not go through the git mailing list, I am resending. Please excuse if it is a duplicate!



----- Forwarded Message ----
> From: dhruva <dhruva@ymail.com>
> To: Simon Hausmann <simon@lst.de>
> Cc: GIT SCM <git@vger.kernel.org>; Jing Xue <jingxue@digizenstudio.com>
> Sent: Wednesday, 10 September, 2008 10:48:23 AM
> Subject: Re: PATCH: git-p4 optional handling of RCS keywords [was: Re: git-p4 and keyword expansion]
> 
> My earlier patch has an error... (I have almost always stumbled on first patch!)
> 
> here is the fixed one:
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2216cac..c67b2e5 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -16,6 +16,9 @@ from sets import Set;
> 
> verbose = False
> 
> +# Handling of RCS keyowrds. To ensure backward compatibility, the default
> +# is to strip keywords. Default behavior is controlled here
> +kwstrip = True
> 
> def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
> @@ -975,10 +978,11 @@ class P4Sync(Command):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
>                  continue
> 
> -            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> -                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> -            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 
> 'binary+k'):
> -                text = 
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', 
> text)
> +            if kwstrip:
> +                if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> +                    text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> +                elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 
> 'binary+k'):
> +                    text = 
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', 
> text)
> 
>              contents[stat['depotFile']] = text
> 
> @@ -1850,6 +1854,16 @@ def main():
>          (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
>      global verbose
>      verbose = cmd.verbose
> +
> +    global kwstrip
> +    kwval = gitConfig("git-p4.kwstrip")
> +    if len(kwval) > 0:
> +       kwval = kwval.lower();
> +        if "false" == kwval:
> +            kwstrip = False
> +        elif "true" == kwval:
> +            kwstrip = True
> +
>      if cmd.needsGit:
>          if cmd.gitdir == None:
>              cmd.gitdir = os.path.abspath(".git")
> 
> 
> 
> -dhruva
> 
> 
> ----- Original Message ----
> > From: dhruva 
> > To: Simon Hausmann 
> > Cc: GIT SCM ; Jing Xue 
> > Sent: Wednesday, 10 September, 2008 10:43:26 AM
> > Subject: PATCH: git-p4 optional handling of RCS keywords [was: Re: git-p4 and 
> keyword expansion]
> > 
> > Hello,
> > I would like to submit my first patch to the git community.
> > 
> > I have introduced a new configuration option to 'git-p4' "kwstrip". If 
> enabled, 
> > the RCS keywords gets unexpanded like it is done with out the patch and 
> > disabling it explicitly retains the RCS keywords as in the original p4 source. 
> 
> > The default (in the absence) is 'false' to ensure backward compatibility. To 
> > override, you can put the following lines in your '.gitconfig' file..
> > 
> > [git-p4]
> >         kwstrip = false
> > 
> > 
> > 
> > The patch to git-p4 (based on origin/next branch):
> > 
> > diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> > index 2216cac..ad37d0b 100755
> > --- a/contrib/fast-import/git-p4
> > +++ b/contrib/fast-import/git-p4
> > @@ -16,6 +16,9 @@ from sets import Set;
> > 
> > verbose = False
> > 
> > +# Handling of RCS keyowrds. To ensure backward compatibility, the default
> > +# is to strip keywords. Default behavior is controlled here
> > +kwstrip = True
> > 
> > def p4_build_cmd(cmd):
> >      """Build a suitable p4 command line.
> > @@ -975,10 +978,11 @@ class P4Sync(Command):
> >                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
> >                  continue
> > 
> > -            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> > -                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> > -            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 
> > 'binary+k'):
> > -                text = 
> > 
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', 
> 
> > text)
> > +            if kwstrip:
> > +                if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> > +                    text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> > +                elif stat['type'] in ('text+k', 'ktext', 'kxtext', 
> 'unicode+k', 
> > 'binary+k'):
> > +                    text = 
> > 
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', 
> 
> > text)
> > 
> >              contents[stat['depotFile']] = text
> > 
> > @@ -1850,6 +1854,16 @@ def main():
> >          (cmd, args) = parser..parse_args(sys..argv[2:], cmd);
> >      global verbose
> >      verbose = cmd.verbose
> > +
> > +    global kwstrip
> > +    kwval = gitConfig("git-p4.kwstrip")
> > +    if len(kwval) > 0:
> > +       kwval = kwval.lower();
> > +        if "false" == kwval:
> > +            kwstrip = False
> > +        else if "true" == kwval:
> > +            kwstrip = True
> > +
> >      if cmd.needsGit:
> >          if cmd.gitdir == None:
> >              cmd.gitdir = os.path.abspath(".git")
> > 
> > 
> > 
> > ----- Original Message ----
> > > From: Jing Xue 
> > > To: dhruva 
> > > Cc: GIT SCM 
> > > Sent: Tuesday, 9 September, 2008 11:08:48 PM
> > > Subject: Re: git-p4 and keyword expansion
> > > 
> > > On Tue, Sep 09, 2008 at 04:44:11PM +0530, dhruva wrote:
> > > > Hello,
> > > 
> > > Hi,
> > > 
> > > > I feel the configuration must be set the first time only, when you
> > > > clone using 'git-p4 clone'. Altering it in between will be very
> > > > confusing!
> > > > Ideally, the setting must be transferred when the git repo
> > > > (cloned from git-p4) is cloned using standard git. Is it something
> > > > possible (well, I am new to git and am exploring. Any extra
> > > > information would help).
> > > >
> > > > My proposal is as follows:
> > > > 1. Add an extra command line argument to 'git-p4 clone' to either  
> > > > enable/disable keyword expansion
> > > > 2. Store that information under the .git folder in a file that is  
> > > > copied when someone clones that repo
> > > > 3. Use the stored information in future 'git-p4 sync/rebase'
> > > 
> > > Any way to make it optional would be welcome by me.
> > 
> > Done
> > 
> > 
> > > If you do come up with a "formal" patch, you might want to
> > > explicitly add Simon Hausmann to the To list, for he's the git-p4
> > > author.
> > 
> > Done
> > 
> > -dhruva
> > 
> > 
> > 
> >       Add more friends to your messenger and enjoy! Go to 
> > http://in.messenger.yahoo.com/invite/
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
>       Unlimited freedom, unlimited storage. Get it now, on 
> http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
