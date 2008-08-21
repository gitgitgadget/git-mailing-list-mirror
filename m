From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit Patch v2 4/7] Use test resources from classpath
Date: Thu, 21 Aug 2008 08:19:04 -0700
Message-ID: <20080821151904.GT3483@spearce.org>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com> <1219288394-1241-2-git-send-email-imyousuf@gmail.com> <1219288394-1241-3-git-send-email-imyousuf@gmail.com> <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 21 17:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBxf-0004im-6O
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbYHUPTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbYHUPTG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:19:06 -0400
Received: from george.spearce.org ([209.20.77.23]:48520 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbYHUPTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:19:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8204238375; Thu, 21 Aug 2008 15:19:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93165>

imyousuf@gmail.com wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> 
> Searched and fixed usage of resources, all tests are now passing and using
> classpath resources.
> 
> A utility class for test classes are created. One of its operation turns
> classpath resources to File and it is used by all test classes to locate
> test resources.

I would change the way you do this series a little bit.

Start the series with this patch, only have JGitTestUtil do:

	return new File("test", name);

like DirCacheCGitCompatabilityTest.pathOf does.  That way you
have the code replacement done in the first step, before you start
mucking around with the resource locations.

In the 2nd patch, change JGitTestUtil to get resources from
the classpath, move (not copy) the resources, and add the
tst-rsc directory to the Eclipse .classpath file.

In the 3rd patch, add your Maven POM file, including the .gitignore
for "target".

The tests will always work, and we don't get this weird copy-delete
pair on the resources.

> +/**
> + *
> + * @author imyousuf
> + */
> +public abstract class JGitTestUtil {

We don't comment classes like this.  Either document it for real,
or remove the Javadoc comment entirely.  In "real" documentation
we do not include @author tags.

> +    public static final String CLASSPATH_TO_RESOURCES =
> +        "/org/spearce/jgit/test/resources/";
> +    private JGitTestUtil() {
> +        throw new AssertionError();
> +    }
> +    
> +    public static File getTestResourceFile(String fileName) {
> +        if(fileName == null || fileName.length() <= 0) {

Formatting error.  We put space between "if(".

> +            return null;
> +        }
> +        URL url = JGitTestUtil.class.getResource(
> +            new StringBuilder(CLASSPATH_TO_RESOURCES)
> +                .append(fileName).toString());
> +        return new File(url.getPath());
> +    }
>  }

-- 
Shawn.
