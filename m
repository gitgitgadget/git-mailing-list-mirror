From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sat, 07 Oct 2006 01:36:26 -0700
Message-ID: <7viriwwmid.fsf@assigned-by-dhcp.cox.net>
References: <20060919212725.GA13132@pasky.or.cz> <ef43do$fm1$1@sea.gmane.org>
	<7vac4qs43g.fsf@assigned-by-dhcp.cox.net>
	<200610061231.06017.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 10:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW7fa-0008QY-Qe
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 10:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJGIg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 04:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWJGIg2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 04:36:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26865 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750910AbWJGIg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 04:36:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007083627.RKQY26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 04:36:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XLcV1V00N1kojtg0000000
	Sat, 07 Oct 2006 04:36:29 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28458>

Jakub Narebski <jnareb@gmail.com> writes:

> Rename $githelp_url and $githelp_label to $logo_url and $logo_label to
> be more obvious what they refer to; while at it add commented out
> previous contents (git documentation at kernel.org). Add comment about
> logo size.
>
> Use $cgi->a(...) to generate Git logo link; it automatically escapes
> attribute values when it is needed.  Escape href attribute using
> esc_url instead of (incorrect!) esc_html.

In principle, I am not sure renaming the variables is a good
idea in general.  Renaming them means you are burning people who
have custom help link defined in their gitweb_config.perl file,
so unless the new variable names are ten times better than the
current one I do not think it is worth doing.

These variables, however, have never been in any official
release nor -rc yet, and have only been there for exactly two
weeks, so if we are going to rename them, we'd better do so now.
And the variables are about the same thing described by $logo
variable, so the new names probably make more sense.

Having said that, I am wondering if it is worth doing something
like this:


sub img_button {
	my $it = $_[0];
	my @attr = ();
        for my $attr (qw(src width height alt class id)) {
		next unless exists $it->{$attr};
                push @attr, "$attr=\"" . esc_attr($it->{$attr}) . '"';
	}
	my $img = '<img ' . join(' ', @attr) . ' />';
	print $cgi->a({ -href => esc_url($it->{'url'}),
        		-title => esc_attr($it->{'title'}),
                      }, $img);
}

our %logo = (
	# logo image button
	src => '++GITWEB_LOGO++',
        width => 72,
        height => 27,
	alt => 'git logo',

	# where that link leads to
        url => 'http:/git.or.cz/',
	title => 'git homepage',
);
