From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/9] completion: optimize refs completion
Date: Fri, 14 Oct 2011 14:16:09 +0200
Message-ID: <20111014121609.GB2208@goldbirke>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
	<1318085683-29830-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 14:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REgls-0007hE-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 14:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab1JNMVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 08:21:43 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:30955 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab1JNMVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 08:21:42 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Oct 2011 08:21:41 EDT
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 14 Oct
 2011 14:16:07 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 14 Oct
 2011 14:16:09 +0200
Content-Disposition: inline
In-Reply-To: <1318085683-29830-3-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183566>

On Sat, Oct 08, 2011 at 04:54:36PM +0200, SZEDER G=E1bor wrote:
> So, add a specialized variant of __gitcomp() that only deals with
> possible completion words separated by a newline=20

> @@ -2635,7 +2659,7 @@ _git ()
>  			"
>  			;;
>  		*)     __git_compute_porcelain_commands
> -		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
> +		       __gitcomp_nl "$__git_porcelain_commands $(__git_aliases)" ;=
;
>  		esac
>  		return
>  	fi

Oops, this last hunk is wrong.

I made the thinko that $__git_porcelain_commands is NL-separated and
the output of __git_aliases() is NL-separated, so we can pass the two
together to the new __gitcomp_nl() function.  But of course not,
because the SP between the two joins the last command and the first
alias.

I will resend in the evening with this hunk removed and the commit
message updated.


G=E1bor
