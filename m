From: "Robert Newson" <robert.newson@gmail.com>
Subject: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 13:58:43 +0100
Message-ID: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 14:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR65I-0003Cb-3X
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 14:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbXHaM6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbXHaM6o
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 08:58:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:6546 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964990AbXHaM6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 08:58:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so944186wah
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 05:58:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BweHRbY0uCaXAeXJmtuVQRFFotvLNXqtZBrwvVvhv3X2QyeMxGODLuhxviurnvpJGU/FGzrtYgEsPltZSunEqaNqKDjOJ8pTd2yUz7Dh2YPBP43ydxLHZ4RFBRbRHPvrVib2m5N+w0FCorJG8bklkJlJi1r1iy1ep9rN0bGBIrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dUBJtNeM3YkCNhXPoNKtjuKZVBm6QHupeWtw3zVsamDnzbvPh4e4gKOMLgreklqKWgb8Lt37V6d/cgmuKE516EnsfAGxwJYkHgjLwL1Vw6aGwR/afR5Gcmpw+gmHm6PQQ3H4A6AgL0e8FbRtss4bz+5AVMw+wujRw/sHyO7+e1Q=
Received: by 10.114.190.6 with SMTP id n6mr762796waf.1188565123410;
        Fri, 31 Aug 2007 05:58:43 -0700 (PDT)
Received: by 10.115.19.3 with HTTP; Fri, 31 Aug 2007 05:58:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57167>

Hi,

The latest head of git gives me this when doing most operations, this
also happens with the rc7 experimental Debian package. It's annoying
because it prints this line hundreds of times for each call to 'log',
for example

"Use of uninitialized value in string eq at blah/git/git-svn line 826."

and this fixes it;

diff --git a/git-svn.perl b/git-svn.perl
index 4e325b7..3d0c76d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -808,7 +808,7 @@ sub cmt_metadata {
 sub working_head_info {
        my ($head, $refs) = @_;
        my ($fh, $ctx) = command_output_pipe('log', $head);
-       my $hash;
+       my $hash = "";
        my %max;
        while (<$fh>) {
                if ( m{^commit ($::sha1)$} ) {
