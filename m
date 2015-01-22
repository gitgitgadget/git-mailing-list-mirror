From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote
 helpers
Date: Fri, 23 Jan 2015 07:13:30 +0900
Message-ID: <20150122221330.GA31912@glandium.org>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
 <xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
 <20150122070301.GA18195@glandium.org>
 <xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
 <20150122080638.GA9546@glandium.org>
 <xmqqoapqu2h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 23:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQ0X-0006TD-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbAVWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:13:42 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43444 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbbAVWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:13:41 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEQ0I-0008Li-9R; Fri, 23 Jan 2015 07:13:30 +0900
Content-Disposition: inline
In-Reply-To: <xmqqoapqu2h4.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262878>

On Thu, Jan 22, 2015 at 09:52:55AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > The patch changes the behavior in all cases, because it didn't feel
> > necessary to have a different behavior between the "normal" case and the
> > '?' case: it makes sense to request the ref being pointed at than the
> > symbolic ref in every case.
> >
> > Moreover, this makes existing non-git remote-helpers work without
> > having to modify them to provide a refspec for HEAD (none of the 5
> > mercurial remote-helpers I checked do).
> 
> I do not question the latter.  It is not surprising if all of them
> share the same limitation that shares the same root in the same
> impedance mismatch.
> 
> The trouble I had in supporting "makes sense ... in every case" was
> that you said that the code as patched would not work for a symref
> pointing at another symref.  The original code did not have that
> problem with remote helpers that support the 'list' command.
> 
> Does the new code avoid regressions for them and if so how?  That is
> what was needed in the justification.
> 
> For remote helpers that support the 'list' command, asking for a
> symref and asking for a ref that the symref points at both work OK
> and behave the same, and hopefully that would be true even when the
> latter is a symref that points yet another ref, so dereferencing
> only one level on our end when making a request, instead of letting
> the remote side dereference, is not likely to cause regression.

If I'm not mistaken, in that case with more than one level of symref,
nothing would break more than it already is, the bug would only not be
fixed for that case. That said, does this theoretical double indirection
actually happen in the wild? For one, afaict, it's not even possible to
create such a double indirection with git update-ref. You have to edit a
.git/refs/ file manually.

Mike
