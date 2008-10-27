From: "Mike Clarke" <clarkema@gmail.com>
Subject: Re: git working tree status
Date: Mon, 27 Oct 2008 12:37:59 +0100
Message-ID: <73f525b90810270437h15479a27j94f45e138449722b@mail.gmail.com>
References: <73f525b90810261454wb902edfk3a696c06ef2148d1@mail.gmail.com>
	 <20081026222335.GJ2273@genesis.frugalware.org>
	 <73f525b90810270412o234bc88by16c67df9df067649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 12:39:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuQRM-0003Lk-H8
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 12:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYJ0LiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYJ0LiD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 07:38:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:18324 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbYJ0LiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 07:38:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2092509rvb.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VqKs1pwz7OVFS5eLPsjU8Qu4KuK5oELak2nXZrSajYs=;
        b=cjj5PxkJMWxLuwcj7TZkSMIrue/XFZnkC9/Tjh46iS3tV0LnCBvtRey71yysW5ZdAy
         f00YmbzROP21/EaR426PD9m6bx582PIHPi+7ppAogfBSM9E1+2XMImfj2oJ8a3vfcbX2
         7I0P0I5Va1kAjvnKPZion00JT18VbKzAiKfzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Nx89nnaKxDq+SJRCv8lomv/J9m7cTXZiODlFXWKj9qR3Bu/G+UVlm26WR3CE1XnawA
         4yVDKe0LDliUIL5RfVKcttFkK+VgagMD0EG1YRbPtcf3xibNFVv1C7xEbL/qBNI3uEK1
         M7Lc4uZOGcFLUZTok02b/X5XYWGUEpkJyM3eI=
Received: by 10.141.198.2 with SMTP id a2mr3169694rvq.219.1225107479619;
        Mon, 27 Oct 2008 04:37:59 -0700 (PDT)
Received: by 10.141.82.19 with HTTP; Mon, 27 Oct 2008 04:37:59 -0700 (PDT)
In-Reply-To: <73f525b90810270412o234bc88by16c67df9df067649@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99226>

On Sun, Oct 26, 2008 at 11:23 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:

> On Sun, Oct 26, 2008 at 09:54:03PM +0000, Mike Clarke <clarkema@gmail.com> wrote:

>> b) all changes checked in, but there are some stashes; or
>
> git update-index -q --refresh
> test -z "$(git diff-index --name-only HEAD --)" && echo "everything committed"
>
>> c) 'dirty' in some way -- new files, uncommitted changes, etc.
>
> git update-index -q --refresh
> test -z "$(git diff-index --name-only HEAD --)" && echo "dirty"
>
> see GIT-VERSION-GEN in git.git
>
>> 1) Is there already some way of doing this that I've overlooked?
>> 2) Would the preferred approach be an option (git status --is-clean)
>> or a sub-command (git is-clean)?  A sub-command would probably result
>> in cleaner internal code, but would also clutter the interface.
>
> I guess you overlooked the fact that plumbing is supposed to be used
> from scripts and porcelain by the users. git status is porcelain, so
> in general just don't use it from scripts.
>
>> 3) Is a patch for such a feature likely to be accepted?
>
> I don't think so, see above.

Thanks for the pointers!  To add a bit of context to the original post, we deal
with a lot of small project repositories at work, and we swap between them
quite a lot.  As a result, management of the repositories can be somewhat
burdensome; it's easy to leave a tree in the middle of something, and
then forget.

To get around this, I'm writing a Perl script, called git-map, which

a) can be used to apply a given git command (say, 'fetch') to a whole group of
   repositories
b) gives you an overview of the state of all your repos.  For example:


546 clarkema@swiss:~/git> git-map summary
 C /home/clarkema/git/apollo
 C /home/clarkema/git/cerebro
 C /home/clarkema/git/dionysus
 S /home/clarkema/git/dotfiles
 C /home/clarkema/git/packaging/eAccelerator.git
 C /home/clarkema/git/programmes/cleo-vc-doc-version-2_0
 D /home/clarkema/git/programmes/cumbria-libraries/cumbria-libraries-version-1_0.git
 C /home/clarkema/git/services/cleo-service-loadbalancers.git
 C /home/clarkema/git/services/cleo-service-proxypac.git
 C /home/clarkema/git/services/cleo-service-vc.git
 C /home/clarkema/git/services/cleo-service-webgw.git
 C /home/clarkema/git/software/configutils.git
 C /home/clarkema/git/software/listbuilder.git
 C /home/clarkema/git/software/luns-sdp
 C /home/clarkema/git/software/proxy-pac.git
 C /home/clarkema/git/software/sgdsync.git
 D /home/clarkema/git/software/vc-billing
 C /home/clarkema/git/toybox/git-contrib-import

This shows me that most of me repos are clean. 'dotfiles' has a stash
on it, and two
others have uncommitted changes.  The code I'm currently using, based
on the comments
above, is:

sub cmd_summary
{
   foreach my $tree ( sort @trees ) {
       local $CWD = $tree;

       system( "$GIT update-index -q --refresh" );

       # The redirection is somewhat dirty; but is designed to eat the error
       # message that occurs if there is no HEAD yet.
       system( "$GIT diff-index --quiet HEAD 2> /dev/null" );

       if ( $CHILD_ERROR == -1 ) {
           print STDERR "Failed to execute $GIT: $OS_ERROR\n";
       }
       elsif ( $CHILD_ERROR & 127 ) {
           printf STDERR "Child died with signal %d\n", ( $CHILD_ERROR & 127 );
       }
       else {
           my $exit_code = $CHILD_ERROR >> 8;

           print " ";
           if ( $exit_code == 0 ) {
               if ( have_stash() ) {
                   print colored ['yellow'], "S";
               }
               else {
                   print colored ['green'], "C";
               }
           }
           elsif ( $exit_code == 1 ) {
               print colored ['red'], "D";
           }
           else {
               print colored ['red'], "?";
           }
           print " $tree\n";
       }
   }
}

sub have_stash
{
   my $ref_stash = 'refs/stash';
   system( "$GIT rev-parse --verify $ref_stash > /dev/null 2>&1" );

   if ( $CHILD_ERROR == -1 ) {
       print STDERR "Failed to execute $GIT: $OS_ERROR\n";
   }
   elsif ( $CHILD_ERROR & 127 ) {
       printf STDERR "Child died with signal %d\n", ( $CHILD_ERROR & 127 );
   }

   return ( $CHILD_ERROR >> 8 ) == 0;
}

Any comments or suggestions to improve the above would be gratefully received!

Thanks,

--
Mike Clarke
