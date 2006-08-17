From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: gitweb: Support for snapshots in gitweb
Date: Thu, 17 Aug 2006 13:18:22 +0530
Message-ID: <cc723f590608170048y44737ab3h497fb22db8605027@mail.gmail.com>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>
	 <44E2F911.6060002@gmail.com> <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net>
	 <44E40CB1.7040805@gmail.com> <7vhd0bu873.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 09:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDcc8-0005IK-AT
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHQHsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 03:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHQHsY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 03:48:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:64793 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932212AbWHQHsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 03:48:24 -0400
Received: by nf-out-0910.google.com with SMTP id o25so892365nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 00:48:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ok4V4JAxv5ogRFbMYAxrYFMnCtqVNWk3eupjuxNoSB4LekPSa9p/StDXuI+OEPLf5j1KxaaPc55bfJzcE4P8nkJcv9QWeChGiQXqge6jeVMzBMHmUuQLQJY7LdBrLbcTisRquuXU8U+LlFD3UB+N8iOVc/tnw/hsnNepfKk1PLA=
Received: by 10.49.93.13 with SMTP id v13mr1881164nfl;
        Thu, 17 Aug 2006 00:48:22 -0700 (PDT)
Received: by 10.49.57.9 with HTTP; Thu, 17 Aug 2006 00:48:22 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd0bu873.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25554>

On 8/17/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
>
> > @@ -2097,6 +2102,23 @@ sub git_tree {
> >       git_footer_html();
> >  }
> >
> > +sub git_snapshot {
> > +     if (!defined $hash) {
> > +             $hash = git_get_head_hash($project);
> > +     }
> > +     print $cgi->header(-type=>'application/x-tar', -Content-Encoding=>'x-gzip',
> > +             '-content-disposition' => "inline; filename=\"$project.tar.gz\"",
> > +             -status=> '200 OK');
>
> These -Mixed-Case, '-sometimes-quoted', spaces sometimes around
> double-arrow sometimes missing, parameters bother me.  Perhaps:
>
>         print $cgi->header(-type => 'application/x-tar',
>                            -content-encoding => 'x-gzip',
>                            -content-disposition =>
>                                "inline; filename=\"$project.tar.gz\"",
>                            -status => '200 OK');
>
> RFC 2616 says that "gzip" content-coding is registered with
> IANA, so I do not think you need to say "x-gzip".
>

Please feel free to change the code. Or if you want me to send another
patch with the changes suggested i can do the same. Let me know.



> > +     open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip -c6" or die_error(undef, "Execute git-tar-tree failed.");
>
> I think this "6" is because somebody suggested to use the
> default "6" instead of "9" in your original and the suggestion
> was because "9" tends to be too expensive.
>
> But if we do not have a good, specific, reason to use "6" (as
> opposed to, say, "5" or "7") and have "6" here only because we
> happen to know "6" is the current gzip default, then probably we
> are better off just letting gzip decide what compression level
> to use without specifying it ourselves?


yes that is correct. I  changed it because it was suggested.

-aneesh
